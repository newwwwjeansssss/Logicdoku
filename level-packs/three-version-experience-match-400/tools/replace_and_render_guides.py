from pathlib import Path
from copy import deepcopy
from itertools import product
from collections import Counter
import hashlib
import json
import math
import sys

from PIL import Image, ImageDraw, ImageFont


ROOT = Path(__file__).resolve().parents[1]
CONFIG = ROOT / '最新版-逐轮优先版-400关.json'
OUTPUT = ROOT / '引导关卡替换对比'
STAGES = [8, 12, 20, 31, 41]
TARGETS = {
    8: {
        'board': [[3, 3, 1, 2], [3, 3, 3, 3], [3, 2, 1, 3], [3, 3, 3, 3]],
        'edges': [(0, 1, 0, 2, 'eq'), (0, 2, 1, 2, 'x'),
                  (2, 0, 2, 1, 'eq'), (2, 1, 3, 1, 'x')],
    },
    12: {'board': [[1, 3, 3, 1], [3, 1, 1, 3], [3, 1, 1, 3], [1, 3, 3, 1]]},
    20: {'board': [[3, 1, 3, 2], [1, 0, 0, 3], [3, 0, 0, 1], [1, 3, 2, 1]]},
    31: {
        'board': [[1, 3, 3, 1], [3, 3, 3, 2], [3, 3, 1, 2], [3, 2, 3, 3]],
        'first': [('col', 1, 1), ('col', 2, 1), ('row', 1, 1), ('row', 2, 1)],
    },
    41: {
        'board': [[3, 3, 3, 1], [3, 3, 3, 3], [3, 1, 3, 3], [3, 3, 3, 3]],
        'corner': [(0, 2, 4), (2, 0, 4)],
    },
}
NAMES = {8: '等号 / 叉号', 12: '色区平衡', 20: '禁用格', 31: '首个太阳位置', 41: '角点太阳计数'}
NOTES = {
    8: '绿色 =：相邻图块相同    红色 ×：相邻图块不同',
    12: '四个 2×2 色区；每个色区太阳、月亮数量相等',
    20: '灰色大叉为禁用格；禁用格不计入行列图块数量',
    31: '边缘数字 2：从顶部 / 左侧数，第 2 格是首个太阳',
    41: '交点数字：相邻四格中的太阳数量；数字 4 表示四格全为太阳',
}


def board_from_json(level):
    n = level['size']
    board = [3] * (n * n)
    for hole in level['holes']:
        board[hole['r'] * n + hole['c']] = 0
    for given in level['givens']:
        i = given['r'] * n + given['c']
        assert board[i] == 3
        board[i] = given['s']
    return board


def constraints(level):
    n = level['size']
    holes = {h['r'] * n + h['c'] for h in level['holes']}
    result = []
    for axis in range(2):
        for k in range(n):
            line = [k * n + j if axis == 0 else j * n + k for j in range(n)]
            active = [i for i in line if i not in holes]
            assert len(active) % 2 == 0
            result.append(('balance', active, 1, len(active) // 2))
            for j in range(n - 2):
                triple = line[j:j + 3]
                if all(i not in holes for i in triple):
                    result.append(('nothree', triple, 0, 0))
    regions = level['regions']
    if regions and isinstance(regions[0], list):
        regions = sum(regions, [])
    for region in sorted(set(regions)):
        if region < 0:
            continue
        cells = [i for i, r in enumerate(regions) if r == region and i not in holes]
        assert len(cells) % 2 == 0
        result.append(('region', cells, 1, len(cells) // 2))
    for edge in level['edges']:
        cells = [edge['r1'] * n + edge['c1'], edge['r2'] * n + edge['c2']]
        assert all(i not in holes for i in cells)
        result.append((edge['t'], cells, 0, 0))
    for clue in level['edgeClues']:
        assert clue['type'] == 'first'
        cells = [clue['index'] * n + j if clue['line'] == 'row' else j * n + clue['index'] for j in range(n)]
        cells = [i for i in cells if i not in holes]
        for j in range(clue['value'] + 1):
            result.append(('first', [cells[j]], clue['symbol'] if j == clue['value'] else 3 - clue['symbol'], 1))
    for clue in level['cornerClues']:
        r, c = clue['r'], clue['c']
        assert 0 <= r < n - 1 and 0 <= c < n - 1
        cells = [r * n + c, r * n + c + 1, (r + 1) * n + c, (r + 1) * n + c + 1]
        result.append(('corner', [i for i in cells if i not in holes], clue['symbol'], clue['value']))
    return result


def valid_solution(board, rules):
    for kind, cells, symbol, target in rules:
        values = [board[i] for i in cells]
        if kind in ('balance', 'region', 'first', 'corner') and values.count(symbol) != target:
            return False
        if kind == 'nothree' and len(set(values)) == 1:
            return False
        if kind == 'eq' and values[0] != values[1]:
            return False
        if kind == 'x' and values[0] == values[1]:
            return False
    return True


def validate_and_propagate(level):
    initial = board_from_json(level)
    rules = constraints(level)
    unknown = [i for i, value in enumerate(initial) if value == 3]
    solutions = []
    for assignments in product((1, 2), repeat=len(unknown)):
        candidate = initial.copy()
        for i, value in zip(unknown, assignments):
            candidate[i] = value
        if valid_solution(candidate, rules):
            solutions.append(candidate)
    assert len(solutions) == 1, (level['stage'], 'solution count', len(solutions))
    board = initial.copy()
    steps = []
    rounds = 0
    while 3 in board:
        moves = {}
        for kind, cells, symbol, target in rules:
            empty = [i for i in cells if board[i] == 3]
            known = [board[i] for i in cells if board[i] != 3]
            deductions = []
            if kind in ('balance', 'region', 'first', 'corner'):
                count = known.count(symbol)
                assert count <= target <= count + len(empty)
                if count == target:
                    deductions = [(i, 3 - symbol) for i in empty]
                elif count + len(empty) == target:
                    deductions = [(i, symbol) for i in empty]
            elif kind == 'nothree':
                if len(empty) == 1 and len(set(known)) == 1:
                    deductions = [(empty[0], 3 - known[0])]
            elif len(empty) == 1:
                deductions = [(empty[0], known[0] if kind == 'eq' else 3 - known[0])]
            for i, value in deductions:
                if i in moves:
                    assert moves[i]['value'] == value
                else:
                    moves[i] = {'index': i, 'value': value, 'round': rounds + 1, 'rule': kind,
                                'cells': cells, 'symbol': symbol, 'target': target,
                                'premises': [{'index': j, 'value': board[j]} for j in cells if board[j] != 3]}
        assert moves, (level['stage'], 'basic propagation stalled')
        rounds += 1
        for i in sorted(moves):
            steps.append(moves[i])
            board[i] = moves[i]['value']
    assert board == solutions[0]
    return board, steps, rounds


def replace_levels(source=None):
    source = source or CONFIG
    raw = source.read_bytes()
    text = raw.decode('utf-8')
    before = json.loads(text)
    if source != CONFIG:
        current = json.loads(CONFIG.read_text(encoding='utf-8'))
        assert current['levels'][:2] == before['levels'][:2], 'The two new introductory levels differ from the saved shifted baseline.'
    assert len(before['levels']) == 400
    assert [l['stage'] for l in before['levels']] == list(range(1, 401))
    after = deepcopy(before)
    for stage, target in TARGETS.items():
        old = before['levels'][stage - 1]
        assert old['size'] == 4
        level = deepcopy(old)
        board = target['board']
        level['givens'] = [{'r': r, 'c': c, 's': board[r][c]} for r in range(4) for c in range(4) if board[r][c] in (1, 2)]
        level['holes'] = [{'r': r, 'c': c} for r in range(4) for c in range(4) if board[r][c] == 0]
        level['edges'] = [dict(zip(('r1', 'c1', 'r2', 'c2', 't'), edge)) for edge in target.get('edges', [])]
        level['edgeClues'] = [{'line': axis, 'index': index, 'type': 'first', 'symbol': 1, 'value': value} for axis, index, value in target.get('first', [])]
        level['cornerClues'] = [{'r': r, 'c': c, 'symbol': 1, 'value': value, 'type': 'corner'} for r, c, value in target.get('corner', [])]
        if stage == 12:
            assert level['regions'] == [0, 0, 1, 1, 0, 0, 1, 1, 2, 2, 3, 3, 2, 2, 3, 3]
        else:
            assert not level['regions']
        solution, steps, rounds = validate_and_propagate(level)
        level['solution'], level['propagationSteps'] = solution, steps
        active = 16 - len(level['holes'])
        unknown = active - len(level['givens'])
        components = {'workload': 25 * unknown / 64, 'unknownRatio': 15 * unknown / active,
                      'rounds': 30 * math.log2(1 + rounds) / math.log2(65), 'remainingRatio': 0.0, 'mechanics': 2.0}
        score = round(sum(components.values()), 4)
        level['validation'] = {'basicComplete': True, 'unique': True, 'solver': 'exhaustive-independent',
                               'secondStatus': 'unsat', 'active': active, 'unknown': unknown,
                               'rounds': rounds, 'remaining': 0, 'mechanics': 1, 'givens': len(level['givens']), 'score': score}
        level['difficultyScores'] = {'model': after['difficultyModel']['id'], 'v2': score,
                                     'components': components, 'calculatedAfterAcceptance': True}
        # Old synthesis targets, acceptance claims and fingerprints no longer describe this map.
        # The complete original metadata is retained in the backup. sourceTarget remains historical.
        for key in ('initialFingerprint', 'generationTarget', 'roundFirstAcceptance'):
            level.pop(key, None)
        after['levels'][stage - 1] = level
    changed = [i + 1 for i, (a, b) in enumerate(zip(before['levels'], after['levels'])) if a != b]
    assert changed == STAGES
    assert [l['id'] for l in before['levels']] == [l['id'] for l in after['levels']]
    assert {k: v for k, v in before.items() if k != 'levels'} == {k: v for k, v in after.items() if k != 'levels'}
    decoder = json.JSONDecoder()
    position = text.index('[', text.index('"levels"')) + 1
    spans = []
    for i in range(400):
        while text[position].isspace() or text[position] == ',':
            position += 1
        _, end = decoder.raw_decode(text, position)
        spans.append((position, end))
        position = end
    newline = '\r\n' if '\r\n' in text else '\n'
    modified = text
    for stage in reversed(STAGES):
        fragment = json.dumps(after['levels'][stage - 1], ensure_ascii=False, indent=2)
        fragment = '\n'.join(('    ' + line if i else line) for i, line in enumerate(fragment.splitlines())).replace('\n', newline)
        start, end = spans[stage - 1]
        modified = modified[:start] + fragment + modified[end:]
    assert json.loads(modified) == after
    backup_dir = ROOT / '备份'
    backup_dir.mkdir(exist_ok=True)
    backup = backup_dir / '最新版-逐轮优先版-400关-五关引导替换前.json'
    if backup.exists() and backup.read_bytes() != raw:
        backup = backup.with_name(backup.stem + '-' + hashlib.sha256(raw).hexdigest()[:12] + '.json')
    if not backup.exists():
        backup.write_bytes(raw)
    CONFIG.write_bytes(modified.encode('utf-8'))
    # Rendering always reads saved JSON files; target descriptions are never rendering inputs.
    saved_before = json.loads(backup.read_text(encoding='utf-8'))
    saved_after = json.loads(CONFIG.read_text(encoding='utf-8'))
    assert saved_after == after
    for i in range(400):
        if i + 1 not in STAGES:
            assert saved_before['levels'][i] == saved_after['levels'][i]
    return backup, saved_before, saved_after


SCALE = 2
FONT = 'C:/Windows/Fonts/msyh.ttc'
BOLD = 'C:/Windows/Fonts/msyhbd.ttc'


def font(size, bold=False):
    return ImageFont.truetype(BOLD if bold else FONT, size * SCALE)


def rectangle(draw, box, **kwargs):
    draw.rounded_rectangle(tuple(round(v * SCALE) for v in box), radius=kwargs.pop('radius', 8) * SCALE,
                           width=kwargs.pop('width', 1) * SCALE, **kwargs)


def label(draw, xy, value, size=18, fill='#27364A', bold=False, anchor='mm'):
    draw.text((xy[0] * SCALE, xy[1] * SCALE), str(value), font=font(size, bold), fill=fill, anchor=anchor)


def sun(draw, cx, cy, radius=19):
    for i in range(12):
        a = i * math.pi / 6
        points = [(cx + radius * math.cos(a - .12), cy + radius * math.sin(a - .12)),
                  (cx + (radius + 8) * math.cos(a), cy + (radius + 8) * math.sin(a)),
                  (cx + radius * math.cos(a + .12), cy + radius * math.sin(a + .12))]
        draw.polygon([(round(x * SCALE), round(y * SCALE)) for x, y in points], fill='#F3AF13')
    draw.ellipse(((cx - radius) * SCALE, (cy - radius) * SCALE, (cx + radius) * SCALE, (cy + radius) * SCALE), fill='#FFD24F', outline='#EAA512', width=2 * SCALE)
    draw.arc(((cx - 12) * SCALE, (cy - 12) * SCALE, (cx + 12) * SCALE, (cy + 12) * SCALE), 195, 265, fill='#FFF2AA', width=3 * SCALE)


def moon(draw, cx, cy):
    # Use an alpha mask for a circular cutout, with no reference image.
    layer = Image.new('RGBA', draw._image.size)
    ld = ImageDraw.Draw(layer)
    ld.ellipse(((cx - 23) * SCALE, (cy - 23) * SCALE, (cx + 23) * SCALE, (cy + 23) * SCALE), fill='#31B9EE')
    mask = Image.new('L', layer.size, 0)
    md = ImageDraw.Draw(mask)
    md.ellipse(((cx - 23) * SCALE, (cy - 23) * SCALE, (cx + 23) * SCALE, (cy + 23) * SCALE), fill=255)
    md.ellipse(((cx - 10) * SCALE, (cy - 32) * SCALE, (cx + 35) * SCALE, (cy + 13) * SCALE), fill=0)
    draw._image.paste(layer, (0, 0), mask)


def badge(draw, cx, cy, text, color, square=False):
    if square:
        rectangle(draw, (cx - 13, cy - 13, cx + 13, cy + 13), fill='white', outline='#D8E0EA', radius=5)
        label(draw, (cx, cy - 1), text, 21, color, True)
    else:
        draw.ellipse(((cx - 14) * SCALE, (cy - 14) * SCALE, (cx + 14) * SCALE, (cy + 14) * SCALE), fill=color, outline='white', width=2 * SCALE)
        label(draw, (cx, cy - 1), text, 17, 'white', True)


def draw_panel(draw, level, px, title, accent):
    n = level['size']
    board = board_from_json(level)
    assert n == 4
    rectangle(draw, (px, 90, px + 548, 555), fill='white', outline='#DFE5EE', radius=16)
    rectangle(draw, (px + 20, 109, px + 150, 141), fill=accent, radius=7, width=0)
    label(draw, (px + 85, 125), title, 16, 'white', True)
    label(draw, (px + 518, 125), f'{n} × {n}', 18, anchor='rm', bold=True)
    x, y, cell, gap = px + 129, 198, 65, 12
    pitch = cell + gap
    regions = level['regions']
    if regions and isinstance(regions[0], list):
        regions = sum(regions, [])
    palette = ['#FCE8E5', '#E5F0FD', '#E6F4EC', '#F5EAFB', '#FFF0D9', '#E1F3F3']
    for r in range(n):
        label(draw, (x - 54, y + r * pitch + cell / 2), r + 1, 13, '#8895A7')
    for c in range(n):
        label(draw, (x + c * pitch + cell / 2, y - 49), c + 1, 13, '#8895A7')
    for r in range(n):
        for c in range(n):
            i = r * n + c
            left, top = x + c * pitch, y + r * pitch
            bg = palette[regions[i] % len(palette)] if regions and regions[i] >= 0 else '#F9FBFE'
            if board[i] == 0:
                bg = '#E1E6ED'
            rectangle(draw, (left, top, left + cell, top + cell), fill=bg, outline='#8EABC8', radius=6)
            cx, cy = left + cell / 2, top + cell / 2
            if board[i] == 1:
                sun(draw, cx, cy)
            elif board[i] == 2:
                moon(draw, cx, cy)
            elif board[i] == 0:
                for a, b in [((-16, -16), (16, 16)), ((-16, 16), (16, -16))]:
                    draw.line(((cx + a[0]) * SCALE, (cy + a[1]) * SCALE, (cx + b[0]) * SCALE, (cy + b[1]) * SCALE), fill='#7B8799', width=8 * SCALE)
    for edge in level['edges']:
        cx = x + (edge['c1'] + edge['c2']) / 2 * pitch + cell / 2
        cy = y + (edge['r1'] + edge['r2']) / 2 * pitch + cell / 2
        badge(draw, cx, cy, '=' if edge['t'] == 'eq' else '×', '#15946B' if edge['t'] == 'eq' else '#D8494A', True)
    for clue in level['edgeClues']:
        if clue['line'] == 'col':
            cx, cy = x + clue['index'] * pitch + cell / 2, y - 16
        else:
            cx, cy = x - 16, y + clue['index'] * pitch + cell / 2
        badge(draw, cx, cy, clue['value'] + 1, '#4276BD')
    for clue in level['cornerClues']:
        cx = x + (clue['c'] + .5) * pitch + cell / 2
        cy = y + (clue['r'] + .5) * pitch + cell / 2
        badge(draw, cx, cy, clue['value'], '#986420')
    empty = board.count(3)
    label(draw, (px + 274, 526), f'预填 {len(level["givens"])} 格  ·  待填 {empty} 格  ·  禁用 {len(level["holes"])} 格', 15, '#5D7087')


def render_comparison(before_level, after_level, path):
    stage = after_level['stage']
    img = Image.new('RGB', (1200 * SCALE, 665 * SCALE), '#F1F5FA')
    draw = ImageDraw.Draw(img)
    label(draw, (36, 39), f'第 {stage} 关  ·  {NAMES[stage]}', 25, bold=True, anchor='lm')
    label(draw, (1164, 39), '替换前后初始地图对比', 17, '#63748B', anchor='rm')
    draw_panel(draw, before_level, 36, '替换前 JSON', '#71829C')
    draw_panel(draw, after_level, 616, '替换后 JSON', '#247B72')
    label(draw, (600, 588), NOTES[stage], 17, '#3E526D')
    label(draw, (600, 623), '仅绘制 JSON 中的初始图块与机制；无图块的有效格为待填格', 14, '#6B7E95')
    label(draw, (600, 648), '两侧分别来自保存的替换前备份 / 当前正式配置，不含答案图块', 12, '#8A99AC')
    img.resize((1200, 665), Image.Resampling.LANCZOS).save(path)


def main():
    source = ROOT / '备份/最新版-逐轮优先版-400关-五关引导替换前.json' if '--restore-shift' in sys.argv else None
    backup, before, after = replace_levels(source)
    OUTPUT.mkdir(exist_ok=True)
    report = {'beforeJson': str(backup), 'afterJson': str(CONFIG),
              'afterSha256': hashlib.sha256(CONFIG.read_bytes()).hexdigest(), 'levelCount': 400,
              'changedStages': STAGES, 'unchangedLevels': 395,
              'renderSource': 'saved JSON only; givens, holes, regions, edges, edgeClues, cornerClues',
              'checks': []}
    for stage in STAGES:
        old = before['levels'][stage - 1]
        new = after['levels'][stage - 1]
        # Validate the exact saved configuration, independently of the construction input.
        solution, steps, rounds = validate_and_propagate(new)
        assert solution == new['solution'] and steps == new['propagationSteps']
        target_flat = sum(TARGETS[stage]['board'], [])
        assert board_from_json(new) == target_flat
        path = OUTPUT / f'第{stage:03d}关-替换前后对比.png'
        render_comparison(old, new, path)
        report['checks'].append({'stage': stage, 'unique': True, 'basicComplete': True,
                                 'givens': len(new['givens']), 'holes': len(new['holes']),
                                 'unknown': new['validation']['unknown'], 'rounds': rounds,
                                 'perRound': list(Counter(step['round'] for step in steps).values()),
                                 'comparisonImage': str(path)})
    (OUTPUT / '核对结果.json').write_text(json.dumps(report, ensure_ascii=False, indent=2), encoding='utf-8')
    images = [OUTPUT / f'第{stage:03d}关-替换前后对比.png' for stage in STAGES]
    body = '\n'.join(f'<section><img src="{p.name}" alt="第{stage}关替换前后地图"></section>' for stage, p in zip(STAGES, images))
    html = '<!doctype html><html lang="zh-CN"><meta charset="utf-8"><title>五关引导替换对比</title><style>body{margin:0;background:#e7edf5;font-family:Microsoft YaHei,sans-serif}main{max-width:1200px;margin:24px auto}p{padding:0 24px;color:#334761}img{display:block;width:100%;height:auto}section{margin:20px 0;box-shadow:0 6px 26px #24436315}</style><main><p>第8、12、20、31、41关已替换。下图分别解析替换前备份和当前正式JSON绘制；其余395关已核对未变。</p>' + body + '</main></html>'
    (OUTPUT / '五关引导替换对比.html').write_text(html, encoding='utf-8')
    print(json.dumps(report, ensure_ascii=False, indent=2))


if __name__ == '__main__':
    main()

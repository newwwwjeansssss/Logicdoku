"""Readable reconstruction of native search/hint control flow, not original C#.
The bundled constraint adapter deliberately supports balance/nothree/edge/holes
only. Other rules fail explicitly; the search functions accept any validator.
"""
from dataclasses import dataclass
from typing import Callable

Validator = Callable[[list[int]], list[set[int]]]

@dataclass(frozen=True)
class Hint:
    index: int
    symbol: int
    reason: str


def solutions(cells: list[int], validate: Validator, limit: int = 2):
    """Row-order iterative DFS, candidate 1 then 2, prune rule violations.

    A defensive initial validation is added here. Native Solve/CountCompletions
    do not visibly perform this check before entering their DFS loops.
    """
    if limit < 1 or validate(cells):
        return []
    work = cells.copy()
    empties = [i for i, v in enumerate(work) if v == 0]
    if not empties:
        return [work]
    tried = [0] * len(empties)
    depth, result = 0, []
    while depth >= 0:
        i = empties[depth]
        found = False
        while tried[depth] < 2:
            tried[depth] += 1
            work[i] = tried[depth]
            if not validate(work):
                found = True
                break
        if not found:
            work[i] = 0
            tried[depth] = 0
            depth -= 1
        elif depth + 1 == len(empties):
            result.append(work.copy())
            if len(result) >= limit:
                break
        else:
            depth += 1
    return result


def local_hint(cells: list[int], validate: Validator, locked=frozenset()):
    work = cells.copy()
    for i, v in enumerate(cells):
        if v != 0 or i in locked:
            continue
        for candidate in (1, 2):
            work[i] = candidate
            bad = any(i in scope for scope in validate(work))
            work[i] = 0
            if bad:
                return Hint(i, 3 - candidate, 'local_violation')
    return None


def get_hint(cells: list[int], validate: Validator, locked=frozenset()):
    hint = local_hint(cells, validate, locked)
    if hint:
        return hint
    work = cells.copy()
    for i, v in enumerate(cells):
        if v != 0 or i in locked:
            continue
        for candidate in (1, 2):
            work[i] = candidate
            possible = bool(solutions(work, validate, 1))
            work[i] = 0
            if not possible:
                return Hint(i, 3 - candidate, 'no_completion')
    return None


def basic_puzzle(puzzle):
    """Adapter for basic-rule fixtures, not a complete native rule port."""
    rules = set(puzzle['rules'])
    unknown = rules - {'balance', 'nothree', 'edge', 'holes'}
    if unknown:
        raise NotImplementedError(f'Unported rules: {sorted(unknown)}')
    n = puzzle['size']
    holes = {h['r'] * n + h['c'] for h in puzzle.get('holes', [])}
    cells = [-1 if i in holes else 0 for i in range(n * n)]
    for g in puzzle['givens']:
        cells[g['r'] * n + g['c']] = g['s']
    lines = [[r*n+c for c in range(n)] for r in range(n)]
    lines += [[r*n+c for r in range(n)] for c in range(n)]
    def validate(board):
        bad = []
        for line in lines:
            playable = [i for i in line if i not in holes]
            if 'balance' in rules:
                half = len(playable) // 2
                if any(sum(board[i] == s for i in playable) > half for s in (1, 2)):
                    bad.append(set(playable))
            if 'nothree' in rules:
                for pos in range(n - 2):
                    trio = line[pos:pos + 3]
                    if all(board[i] == 1 for i in trio) or all(board[i] == 2 for i in trio):
                        bad.append(set(trio))
        if 'edge' in rules:
            for e in puzzle.get('edges', []):
                a, b = e['r1']*n+e['c1'], e['r2']*n+e['c2']
                if e['t'] not in ('eq', 'x'):
                    raise ValueError(e['t'])
                if board[a] > 0 and board[b] > 0 and ((board[a] == board[b]) != (e['t'] == 'eq')):
                    bad.append({a, b})
        return bad
    return cells, validate

if __name__ == '__main__':
    import argparse, json
    from pathlib import Path
    parser = argparse.ArgumentParser()
    parser.add_argument('--level', default='5')
    args = parser.parse_args()
    p = json.loads((Path(__file__).resolve().parents[1]/'levels/Test1.puzzles.json').read_text())[args.level]
    cells, validator = basic_puzzle(p)
    found = solutions(cells, validator)
    print(json.dumps({'level': args.level, 'solutions_capped_at_2': len(found),
                      'first_solution': found[0] if found else None,
                      'local_hint': vars(local_hint(cells, validator)) if local_hint(cells, validator) else None}, indent=2))

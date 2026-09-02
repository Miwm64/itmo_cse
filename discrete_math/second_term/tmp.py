
import math
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np
from matplotlib.path import Path as MplPath
from matplotlib.patches import PathPatch


VERTEX_COUNT = 12

# Рёбра первого планарного суграфа.
INSIDE_EDGES = [
    (1, 5),
    (5, 11),
    (5, 7),
    (5, 10),
    (7, 9),
    (7, 10),
]

OUTSIDE_EDGES = [
    (1, 7),
    (3, 6),
    (3, 7),
    (7, 12),
    (8, 11),
]

OUTPUT_FILE = Path("subgraph_1.png")


def create_positions(vertex_count: int) -> dict[int, np.ndarray]:
    """Располагает вершины на окружности по часовой стрелке."""
    positions = {}

    for vertex in range(1, vertex_count + 1):
        angle = math.pi / 2 - 2 * math.pi * (vertex - 1) / vertex_count
        positions[vertex] = np.array([math.cos(angle), math.sin(angle)])

    return positions


def draw_hamiltonian_cycle(ax, positions: dict[int, np.ndarray]) -> None:
    """Рисует внешний гамильтонов цикл."""
    for vertex in range(1, VERTEX_COUNT + 1):
        next_vertex = vertex % VERTEX_COUNT + 1

        x1, y1 = positions[vertex]
        x2, y2 = positions[next_vertex]

        ax.plot([x1, x2], [y1, y2], linewidth=2)


def draw_inside_edge(
        ax,
        positions: dict[int, np.ndarray],
        edge: tuple[int, int],
) -> None:
    """Рисует ребро внутри гамильтонова цикла."""
    start, end = edge

    x1, y1 = positions[start]
    x2, y2 = positions[end]

    ax.plot([x1, x2], [y1, y2], linewidth=1.8)


def draw_outside_edge(
        ax,
        positions: dict[int, np.ndarray],
        edge: tuple[int, int],
        radius: float = 2.0,
) -> None:
    """Рисует ребро снаружи гамильтонова цикла кривой Безье."""
    start, end = edge

    point1 = positions[start]
    point2 = positions[end]

    angle1 = math.atan2(point1[1], point1[0])
    angle2 = math.atan2(point2[1], point2[0])

    delta = (angle2 - angle1 + math.pi) % (2 * math.pi) - math.pi

    # Для диаметрально противоположных вершин выбираем одну из сторон.
    if abs(abs(delta) - math.pi) < 1e-9:
        delta = math.pi

    middle_angle = angle1 + delta / 2

    control_point = np.array([
        radius * math.cos(middle_angle),
        radius * math.sin(middle_angle),
        ])

    vertices = [
        tuple(point1),
        tuple(control_point),
        tuple(point2),
    ]

    codes = [
        MplPath.MOVETO,
        MplPath.CURVE3,
        MplPath.CURVE3,
    ]

    path = MplPath(vertices, codes)
    patch = PathPatch(path, fill=False, linewidth=1.8)

    ax.add_patch(patch)


def draw_vertices(ax, positions: dict[int, np.ndarray]) -> None:
    """Рисует вершины и их обозначения."""
    for vertex, point in positions.items():
        x, y = point

        ax.scatter(x, y, s=180, zorder=5)
        ax.text(
            x,
            y,
            f"e{vertex}",
            ha="center",
            va="center",
            fontsize=9,
            zorder=6,
        )


def main() -> None:
    positions = create_positions(VERTEX_COUNT)

    figure, ax = plt.subplots(figsize=(10, 10))

    draw_hamiltonian_cycle(ax, positions)

    for edge in INSIDE_EDGES:
        draw_inside_edge(ax, positions, edge)

    for edge in OUTSIDE_EDGES:
        draw_outside_edge(ax, positions, edge)

    draw_vertices(ax, positions)

    ax.set_title(
        "Первый планарный суграф:\n"
        "ψ9 внутри гамильтонова цикла, ψ13 снаружи"
    )

    ax.set_aspect("equal")
    ax.set_xlim(-2.4, 2.4)
    ax.set_ylim(-2.4, 2.4)
    ax.axis("off")

    figure.tight_layout()
    figure.savefig(OUTPUT_FILE, dpi=300, bbox_inches="tight")

    print(f"Изображение сохранено: {OUTPUT_FILE.resolve()}")


if __name__ == "__main__":
    main()


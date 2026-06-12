import networkx as nx
import matplotlib.pyplot as plt

# Матрица варианта 18
matrix = [
    [0, 0, 1, 2, 4, 5, 2, 3, 4, 2, 2, 0],
    [0, 0, 4, 2, 0, 0, 2, 1, 4, 0, 0, 2],
    [1, 4, 0, 0, 0, 4, 0, 5, 2, 3, 2, 0],
    [2, 2, 0, 0, 0, 3, 3, 0, 5, 5, 2, 5],
    [4, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0],
    [5, 0, 4, 3, 3, 0, 0, 5, 0, 1, 4, 5],
    [2, 2, 0, 3, 0, 0, 0, 0, 0, 5, 0, 0],
    [3, 1, 5, 0, 0, 5, 0, 0, 2, 0, 0, 0],
    [4, 4, 2, 5, 0, 0, 0, 2, 0, 5, 0, 1],
    [2, 0, 3, 5, 0, 1, 5, 0, 5, 0, 4, 0],
    [2, 0, 2, 2, 0, 4, 0, 0, 0, 4, 0, 0],
    [0, 2, 0, 5, 0, 5, 0, 0, 1, 0, 0, 0]
]

vertices = [f'e{i}' for i in range(1, 13)]

# Создаём граф
G = nx.Graph()
G.add_nodes_from(vertices)
for i in range(12):
    for j in range(i + 1, 12):
        if matrix[i][j] > 0:
            G.add_edge(vertices[i], vertices[j], weight=matrix[i][j])

# Позиции вершин
pos = {
    'e1': (5, 0), 'e2': (8, 1), 'e3': (0, 5), 'e4': (10, 4),
    'e5': (9, 1), 'e6': (6, 4), 'e7': (4, 8), 'e8': (3, 2),
    'e9': (3.5, 5.5), 'e10': (7.5, 9), 'e11': (5.5, 6), 'e12': (7, 2.5)
}

# ========== КАРТИНКА 1: Исходный граф ==========
fig, ax = plt.subplots(figsize=(14, 10))

# Рисуем рёбра
for u, v in G.edges():
    x = [pos[u][0], pos[v][0]]
    y = [pos[u][1], pos[v][1]]
    ax.plot(x, y, color='lightgray', linewidth=1.5, zorder=1)

    # Подпись веса ребра
    mid_x = (x[0] + x[1]) / 2
    mid_y = (y[0] + y[1]) / 2
    ax.text(mid_x, mid_y, str(G[u][v]['weight']),
            fontsize=10, color='darkblue', fontweight='bold',
            bbox=dict(boxstyle='round,pad=0.2', facecolor='lightyellow', alpha=0.7))

# Рисуем вершины
for v in vertices:
    color = 'lightblue'
    size = 800
    if v == 'e1':
        color = 'green'
        size = 1200
    elif v == 'e12':
        color = 'red'
        size = 1200

    ax.scatter(pos[v][0], pos[v][1], s=size, c=color, zorder=2, edgecolors='black')
    ax.text(pos[v][0], pos[v][1], v, fontsize=11, fontweight='bold',
            ha='center', va='center', zorder=3)

ax.text(pos['e1'][0], pos['e1'][1] - 0.5, 's=e1', fontsize=10,
        ha='center', color='green', fontweight='bold')
ax.text(pos['e12'][0], pos['e12'][1] - 0.5, 't=e12', fontsize=10,
        ha='center', color='red', fontweight='bold')

plt.title('Исходный граф (Вариант 18)', fontsize=14, fontweight='bold')
plt.axis('off')
plt.tight_layout()
plt.savefig('1_исходный_граф.png', dpi=150, bbox_inches='tight')
plt.show()

# ========== КАРТИНКА 2: Разрез K1 ==========
fig, ax = plt.subplots(figsize=(14, 10))

# Рисуем все рёбра серым
for u, v in G.edges():
    x = [pos[u][0], pos[v][0]]
    y = [pos[u][1], pos[v][1]]
    ax.plot(x, y, color='lightgray', linewidth=1, zorder=1)

# Выделяем рёбра из разреза K1 (из e1)
edges_from_e1 = [(u, v) for u, v in G.edges() if u == 'e1' or v == 'e1']
for u, v in edges_from_e1:
    x = [pos[u][0], pos[v][0]]
    y = [pos[u][1], pos[v][1]]
    ax.plot(x, y, color='blue', linewidth=3, zorder=1)

    mid_x = (x[0] + x[1]) / 2
    mid_y = (y[0] + y[1]) / 2
    ax.text(mid_x, mid_y, str(G[u][v]['weight']),
            fontsize=12, color='blue', fontweight='bold',
            bbox=dict(boxstyle='round,pad=0.3', facecolor='white', alpha=0.9))

# Рисуем вершины
for v in vertices:
    color = 'lightblue'
    size = 800
    if v == 'e1':
        color = 'green'
        size = 1200
    elif v == 'e12':
        color = 'red'
        size = 1200

    ax.scatter(pos[v][0], pos[v][1], s=size, c=color, zorder=2, edgecolors='black')
    ax.text(pos[v][0], pos[v][1], v, fontsize=11, fontweight='bold',
            ha='center', va='center', zorder=3)

# Рисуем линию разреза
ax.plot([2, 9], [7, 1], color='orange', linewidth=3, linestyle='--', label='Разрез K1', zorder=4)
ax.text(5.5, 4, 'K1', fontsize=16, color='orange', fontweight='bold')

ax.text(pos['e1'][0], pos['e1'][1] - 0.5, 's=e1', fontsize=10,
        ha='center', color='green', fontweight='bold')
ax.text(pos['e12'][0], pos['e12'][1] - 0.5, 't=e12', fontsize=10,
        ha='center', color='red', fontweight='bold')

plt.title('Разрез K1 = ({e1}, V\\{e1}), Q1 = max = 5', fontsize=14, fontweight='bold')
plt.legend(fontsize=12)
plt.axis('off')
plt.tight_layout()
plt.savefig('2_разрез_K1.png', dpi=150, bbox_inches='tight')
plt.show()

# ========== КАРТИНКА 3: Граф после закорачивания ==========
fig, ax = plt.subplots(figsize=(14, 10))

# Компоненты связности после закорачивания рёбер с q >= 5
# {e1, e3, e4, e6, e7, e8, e9, e10, e12} - одна большая компонента
# {e2}, {e5}, {e11} - изолированные вершины

# Позиции для сгруппированного графа
pos_grouped = {
    'group1': (7, 5),  # Большая компонента {e1, e3, e4, e6, e7, e8, e9, e10, e12}
    'e2': (2, 8),
    'e5': (12, 2),
    'e11': (2, 2)
}

# Рисуем рёбра между группами (только те, что < 5)
# Рёбра между group1 и e2
ax.plot([pos_grouped['group1'][0], pos_grouped['e2'][0]],
        [pos_grouped['group1'][1], pos_grouped['e2'][1]],
        color='lightgray', linewidth=2, zorder=1)
ax.text(4.5, 6.5, '4', fontsize=12, color='darkblue', fontweight='bold',
        bbox=dict(boxstyle='round,pad=0.2', facecolor='lightyellow', alpha=0.7))

# Рёбра между group1 и e5
ax.plot([pos_grouped['group1'][0], pos_grouped['e5'][0]],
        [pos_grouped['group1'][1], pos_grouped['e5'][1]],
        color='lightgray', linewidth=2, zorder=1)
ax.text(9.5, 3.5, '4', fontsize=12, color='darkblue', fontweight='bold',
        bbox=dict(boxstyle='round,pad=0.2', facecolor='lightyellow', alpha=0.7))

# Рёбра между group1 и e11
ax.plot([pos_grouped['group1'][0], pos_grouped['e11'][0]],
        [pos_grouped['group1'][1], pos_grouped['e11'][1]],
        color='lightgray', linewidth=2, zorder=1)
ax.text(4.5, 3.5, '2', fontsize=12, color='darkblue', fontweight='bold',
        bbox=dict(boxstyle='round,pad=0.2', facecolor='lightyellow', alpha=0.7))

# Рисуем группы вершин
# Большая группа
circle1 = plt.Circle(pos_grouped['group1'], 1.5, color='yellow',
                     edgecolor='black', linewidth=2, zorder=2)
ax.add_patch(circle1)
ax.text(pos_grouped['group1'][0], pos_grouped['group1'][1] + 0.3,
        'e1, e3, e4, e6,\ne7, e8, e9,\ne10, e12',
        fontsize=9, fontweight='bold', ha='center', va='center', zorder=3)
ax.text(pos_grouped['group1'][0], pos_grouped['group1'][1] - 1.8,
        's=e1, t=e12', fontsize=10, color='red', fontweight='bold', ha='center')

# Изолированные вершины
for v in ['e2', 'e5', 'e11']:
    ax.scatter(pos_grouped[v][0], pos_grouped[v][1], s=800,
               c='lightblue', zorder=2, edgecolors='black')
    ax.text(pos_grouped[v][0], pos_grouped[v][1], v, fontsize=12,
            fontweight='bold', ha='center', va='center', zorder=3)

plt.title('Граф G1 после закорачивания рёбер с q ≥ 5\nВершины s и t объединены',
          fontsize=14, fontweight='bold')
plt.axis('off')
plt.xlim(0, 14)
plt.ylim(0, 10)
plt.tight_layout()
plt.savefig('3_граф_после_закорачивания.png', dpi=150, bbox_inches='tight')
plt.show()

print("Готово! Сохранены 3 картинки:")
print("1_исходный_граф.png")
print("2_разрез_K1.png")
print("3_граф_после_закорачивания.png")

import networkx as nx
import matplotlib.pyplot as plt

# Матрица варианта 18
matrix = [
    [0, 0, 1, 2, 4, 5, 2, 3, 4, 2, 2, 0],
    [0, 0, 4, 2, 0, 0, 2, 1, 4, 0, 0, 2],
    [1, 4, 0, 0, 0, 4, 0, 5, 2, 3, 2, 0],
    [2, 2, 0, 0, 0, 3, 3, 0, 5, 5, 2, 5],
    [4, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0],
    [5, 0, 4, 3, 3, 0, 0, 5, 0, 1, 4, 5],
    [2, 2, 0, 3, 0, 0, 0, 0, 0, 5, 0, 0],
    [3, 1, 5, 0, 0, 5, 0, 0, 2, 0, 0, 0],
    [4, 4, 2, 5, 0, 0, 0, 2, 0, 5, 0, 1],
    [2, 0, 3, 5, 0, 1, 5, 0, 5, 0, 4, 0],
    [2, 0, 2, 2, 0, 4, 0, 0, 0, 4, 0, 0],
    [0, 2, 0, 5, 0, 5, 0, 0, 1, 0, 0, 0]
]

vertices = [f'e{i}' for i in range(1, 13)]

# Создаём граф
G = nx.Graph()
G.add_nodes_from(vertices)
for i in range(12):
    for j in range(i + 1, 12):
        if matrix[i][j] > 0:
            G.add_edge(vertices[i], vertices[j], weight=matrix[i][j])

# ========== КАРТИНКА: Граф после закорачивания с группировкой ==========
fig, ax = plt.subplots(figsize=(16, 10))

# Компоненты связности после закорачивания рёбер с q >= 5
# Большая компонента: {e1, e3, e4, e6, e7, e8, e9, e10, e12}
# Одиночные: e2, e5, e11

# Позиции вершин - большая компонента в кластере (слева), одиночные справа
pos = {
    # Большая компонента (кластер слева)
    'e1': (2.0, 2.0),
    'e3': (1.0, 5.0),
    'e4': (4.5, 4.5),
    'e6': (3.0, 4.0),
    'e7': (2.5, 6.0),
    'e8': (1.5, 3.0),
    'e9': (2.0, 4.5),
    'e10': (3.5, 6.0),
    'e12': (4.0, 3.0),
    # Одиночные вершины (справа)
    'e2': (8.0, 5.0),
    'e5': (8.0, 2.0),
    'e11': (8.0, 7.0),
}

# Рисуем все рёбра < 5 (серые, тонкие)
edges_lt5 = [(u, v) for u, v in G.edges() if G[u][v]['weight'] < 5]
for u, v in edges_lt5:
    x = [pos[u][0], pos[v][0]]
    y = [pos[u][1], pos[v][1]]
    ax.plot(x, y, color='lightgray', linewidth=1, zorder=1, alpha=0.5)

# Рисуем рёбра >= 5 (оранжевые, жирные) - закороченные
edges_ge5 = [(u, v) for u, v in G.edges() if G[u][v]['weight'] >= 5]
for u, v in edges_ge5:
    x = [pos[u][0], pos[v][0]]
    y = [pos[u][1], pos[v][1]]
    ax.plot(x, y, color='orange', linewidth=3, zorder=1, alpha=0.7)

# Выделяем путь e1 -> e6 -> e12 красным
path_edges = [('e1', 'e6'), ('e6', 'e12')]
for u, v in path_edges:
    x = [pos[u][0], pos[v][0]]
    y = [pos[u][1], pos[v][1]]
    ax.plot(x, y, color='red', linewidth=4, zorder=2)

# Подписи весов рёбер >= 5
for u, v in edges_ge5:
    mid_x = (pos[u][0] + pos[v][0]) / 2
    mid_y = (pos[u][1] + pos[v][1]) / 2
    ax.text(mid_x, mid_y, str(G[u][v]['weight']),
            fontsize=9, color='darkorange', fontweight='bold',
            bbox=dict(boxstyle='round,pad=0.2', facecolor='white', alpha=0.8),
            zorder=3)

# Рисуем вершины большой компоненты (жёлтые - объединены)
big_component = ['e1', 'e3', 'e4', 'e6', 'e7', 'e8', 'e9', 'e10', 'e12']
for v in big_component:
    color = 'yellow'
    size = 1000
    if v == 'e1':
        color = 'green'
        size = 1200
    elif v == 'e12':
        color = 'red'
        size = 1200

    ax.scatter(pos[v][0], pos[v][1], s=size, c=color, zorder=4,
               edgecolors='black', linewidths=2)
    ax.text(pos[v][0], pos[v][1], v, fontsize=10, fontweight='bold',
            ha='center', va='center', zorder=5)

# Рисуем одиночные вершины (голубые)
isolated = ['e2', 'e5', 'e11']
for v in isolated:
    ax.scatter(pos[v][0], pos[v][1], s=1000, c='lightblue', zorder=4,
               edgecolors='black', linewidths=2)
    ax.text(pos[v][0], pos[v][1], v, fontsize=10, fontweight='bold',
            ha='center', va='center', zorder=5)

# Подписи s и t
ax.text(pos['e1'][0], pos['e1'][1] - 0.4, 's', fontsize=11,
        ha='center', color='green', fontweight='bold')
ax.text(pos['e12'][0], pos['e12'][1] - 0.4, 't', fontsize=11,
        ha='center', color='red', fontweight='bold')

# Обводка большой компоненты (пунктирный овал)
from matplotlib.patches import Ellipse

ellipse = Ellipse((2.5, 4.0), 4.5, 5.5, fill=False,
                  edgecolor='blue', linewidth=2, linestyle='--',
                  label='Компонента связности (q ≥ 5)')
ax.add_patch(ellipse)

# Легенда
ax.plot([], [], color='orange', linewidth=3, label='Закороченные рёбра (q ≥ 5)')
ax.plot([], [], color='red', linewidth=4, label='Путь: e1 → e6 → e12')
ax.scatter([], [], s=1000, c='yellow', edgecolors='black', label='Объединённые вершины')
ax.scatter([], [], s=1000, c='lightblue', edgecolors='black', label='Изолированные вершины')

plt.title('Граф G1 после закорачивания рёбер с q ≥ 5\nВершины s=e1 и t=e12 объединены в одну компоненту',
          fontsize=13, fontweight='bold', pad=15)
plt.legend(loc='upper right', fontsize=9)
plt.axis('off')
plt.xlim(0, 10)
plt.ylim(0, 9)
plt.tight_layout()
plt.savefig('граф_после_закорачивания_группировка.png', dpi=150, bbox_inches='tight')
plt.show()

print("Готово! Картинка сохранена: граф_после_закорачивания_группировка.png")
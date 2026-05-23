import numpy as np
import matplotlib.pyplot as plt
import os

# --- Data & Setup (Variant 2) ---
y_data = [7.38, 6.76, 5.22, 3.47, 2.07, 1.16, 0.64, 0.36, 0.23, 0.16,
          0.13, 0.13, 0.16, 0.23, 0.37, 0.64, 1.16, 2.08, 3.48, 5.22, 6.76]
y = np.array(y_data)

n_amount = 10
i_amount = n_amount * 2 + 1

thetas = np.array([])
for i in range(1, i_amount+1):
    thetas = np.append(thetas, 2*np.pi*(i-1)/i_amount)

# --- Calculate Coefficients ---
a0 = (2.0 / i_amount) * np.sum(y)

ak = np.zeros(6)
bk = np.zeros(6)

for k in range(1, 6):
    ck = np.cos(k * thetas)
    sk = np.sin(k * thetas)

    dot_y_ck = np.dot(y, ck)
    dot_y_sk = np.dot(y, sk)

    ak[k] = (2.0 / i_amount) * dot_y_ck
    bk[k] = (2.0 / i_amount) * dot_y_sk

print("Coefficients:")
print(f"a0/2 = {a0/2:.6f}")
for k in range(1, 6):
    print(f"k={k}: a{k}={ak[k]:.6f}, b{k}={bk[k]:.6f}")

# --- Reconstruct Signal f & Error e ---
f = np.full(i_amount, a0 / 2.0)

for k in range(1, 6):
    cos_term = ak[k] * np.cos(k * thetas)
    sin_term = bk[k] * np.sin(k * thetas)
    f += cos_term + sin_term

e = y - f

# --- Metrics ---
epsilon_abs = np.linalg.norm(e)
norm_y = np.linalg.norm(y)
epsilon_rel = epsilon_abs / norm_y
R_squared = (1 - (epsilon_abs**2 / norm_y**2)) * 100

print(f"\nMetrics:")
print(f"Abs Error: {epsilon_abs:.6f}")
print(f"Rel Error: {epsilon_rel:.6f}")
print(f"R^2: {R_squared:.4f}%")

# --- Orthogonality Check (Section 4.2) ---
# Build basis vectors: 1, c1, s1, ..., c5, s5
basis_vecs = [np.ones(i_amount)]
basis_names = ['1']
for k in range(1, 6):
    basis_vecs.append(np.cos(k * thetas))
    basis_names.append(f'c{k}')
    basis_vecs.append(np.sin(k * thetas))
    basis_names.append(f's{k}')

max_dot = 0
is_orthogonal = True
print("\nOrthogonality Check:")
for i in range(len(basis_vecs)):
    for j in range(i + 1, len(basis_vecs)):
        dot_val = np.dot(basis_vecs[i], basis_vecs[j])
        if abs(dot_val) > max_dot:
            max_dot = abs(dot_val)
        if abs(dot_val) > 1e-10:
            is_orthogonal = False
            print(f"WARNING: Non-orthogonal pair {basis_names[i]} & {basis_names[j]}: {dot_val:.2e}")

if is_orthogonal:
    print(f"Basis is orthogonal. Max scalar product: {max_dot:.2e}")
else:
    print("Basis is NOT orthogonal.")

# --- Visualization (Section 4.4) ---
script_dir = os.path.dirname(os.path.abspath(__file__))

# Graph 1: Approximation
plt.figure(figsize=(10, 6))
plt.plot(thetas, y, 'ro', label='Experimental Data (y)', markersize=5)
plt.plot(thetas, f, 'b-', linewidth=2, label='Model (f)')
plt.ylabel('Concentration')
plt.xlabel('Phase θ (rad)')
plt.title('1. Data vs Approximation (Variant 2)')
plt.legend(loc='upper right')
plt.grid(True, linestyle='--', alpha=0.6)
plt.tight_layout()
save_path_1 = os.path.join(script_dir, 'graph_1_approximation.png')
plt.savefig(save_path_1, dpi=300)
print(f"Graph 1 saved: {save_path_1}")
plt.show()

# Graph 2: Error
plt.figure(figsize=(10, 6))
plt.plot(thetas, e, 'g-', marker='o', markersize=4, label='Error Vector (e = y - f)')
plt.axhline(0, color='black', linewidth=0.8)
plt.ylabel('Error')
plt.xlabel('Phase θ (rad)')
plt.title('2. Orthogonal Component (Analyzer Noise)')
plt.legend(loc='upper right')
plt.grid(True, linestyle='--', alpha=0.6)
plt.tight_layout()
save_path_2 = os.path.join(script_dir, 'graph_2_error.png')
plt.savefig(save_path_2, dpi=300)
print(f"Graph 2 saved: {save_path_2}")
plt.show()

# Graph 3: Spectrum
plt.figure(figsize=(10, 6))
k_vals = np.arange(0, 6)
a_coeffs_plot = [a0/2] + list(ak[1:])
b_coeffs_plot = [0] + list(bk[1:])

x_pos_a = k_vals - 0.2
x_pos_b = k_vals + 0.2
bar_width = 0.4

plt.bar(x_pos_a, np.abs(a_coeffs_plot), width=bar_width, label='|ak| (Cos)', color='skyblue')
plt.bar(x_pos_b, np.abs(b_coeffs_plot), width=bar_width, label='|bk| (Sin)', color='salmon')

plt.xticks(k_vals, [f'k={k}' for k in k_vals])
plt.ylabel('Amplitude')
plt.xlabel('Harmonic Number (k)')
plt.title('3. Spectral Analysis')
plt.legend()
plt.grid(True, axis='y', linestyle='--', alpha=0.6)
plt.tight_layout()
save_path_3 = os.path.join(script_dir, 'graph_3_spectrum.png')
plt.savefig(save_path_3, dpi=300)
print(f"Graph 3 saved: {save_path_3}")
plt.show()

print("All graphs displayed and saved.")
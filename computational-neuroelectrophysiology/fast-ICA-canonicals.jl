using CairoMakie

# parameter first
a1 = rand() * (2 - 1) + 1   # pick a random a1 in [1,2]

# Canonical choices for G
G1(u) = (1/a1) * log(cosh(a1*u))          # smooth, robust
G2(u) = -exp(-0.5 * u^2)                  # super-Gaussian
G3(u) = (u^4)/4                           # kurtosis

xs = randn(100)

fig = Figure(size = (800, 1000))
ax = Axis(fig[1, 1])
scatter!(ax, xs, G1.(xs), label = "logcosh", color = :navy)
scatter!(ax, xs, G2.(xs), label = "superGaussian", color = :darkcyan)
scatter!(ax, xs, G3.(xs), label = "kurtosis", color = :red)
fig

using Statistics

mean(G1.(randn(1000)))

observed = [mean(G1.(randn(1000))) for i in 1:1000];
ax2 = Axis(fig[2, 1])

scatter!(ax2, observed)

μ = mean(observed)

hlines!(ax2, [μ]; linewidth=3, color=:red)

# place label at (x = right edge, y = μ)
text!(ax2,
      0, μ+0.01,                             # coordinates
      text = "mean = $(round(μ, digits=3))",
      align = (:left, :center),
      color = :red)

Legend(fig[1, 2], ax)

fig
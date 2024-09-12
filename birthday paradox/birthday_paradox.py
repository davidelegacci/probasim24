
import matplotlib.pyplot as plt
from math import factorial as fac

# Year range

year = 365


# Probability function
def f(n):
	return 1 - fac(year) / ( year**n * fac(year-n) )


# Data
X = range(year)
Y = [f(n) for n in X]


# Plot custom dates
dates = [23, 70]
probs = [f(n) for n in dates]
plt.scatter(dates, probs)

# Add dashed lines corresponding to specific dates
for i, d in enumerate(dates):
	plt.plot([0, dates[i]], [probs[i], probs[i]], 'k--')
	plt.plot([dates[i], dates[i]], [0, probs[i]], 'k--')


# Plot
plt.plot(X, Y)


# Add ticks corresponding to custom dates
current_xticks = plt.gca().get_xticks().tolist()  # Get current x ticks
current_yticks = plt.gca().get_yticks().tolist()  # Get current y ticks

new_xticks = current_xticks + dates  # Add dates to x ticks
new_yticks = current_yticks[0:-2] + probs # Add probs to y ticks

plt.xticks(new_xticks)
plt.yticks(new_yticks)

# Labels
plt.xlabel("Number of people")
plt.ylabel("Probability that at least two have the same birthday")
plt.title("Birthday paradox")

# Set domain and codomain
plt.xlim(0, year)
plt.ylim(0, 1.05)


plt.savefig('./birthday_paradox.pdf')

import matplotlib.pyplot as plt
from math import factorial as fac

year = 365

def f(n):
	return 1 - fac(year) / ( year**n * fac(year-n) )

X = range(year)
Y = [f(n) for n in X]

dates = [23, 70]
probs = [f(n) for n in dates]

plt.scatter(dates, probs)

for i, d in enumerate(dates):
	plt.plot([0, dates[i]], [probs[i], probs[i]], 'k--')
	plt.plot([dates[i], dates[i]], [0, probs[i]], 'k--')


plt.plot(X, Y)
plt.xlim(0, year)
plt.ylim(0, 1.05)


# Set the ticks manually
current_xticks = plt.gca().get_xticks().tolist()  # Get current x ticks


current_yticks = plt.gca().get_yticks().tolist()  # Get current y ticks

new_xticks = current_xticks + dates  # Add dates to x ticks

new_yticks = current_yticks + probs  # Add probs to y ticks

plt.xlabel("Number of people")
plt.ylabel("Probability that at least two have the same birthday")
plt.title("Birthday paradox")

plt.xticks(new_xticks)
plt.yticks(new_yticks)

plt.show()
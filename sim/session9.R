N=100000

# draw N random integers between 1 and 4, allowing repetition (replace = TRUE) with uniform probability

# associate 1 = FF, 2 = FM, 3 = MF, 4 = MM

# every drawn integer is a family instance (two children, either male or female)

S=sample(x=1:4,size=N,replace=T)
#print(S)

# we want to se how many times
# - given that one is a girl, so eliminate 4
# - the other is a boy, (eliminate 1)

prob=mean(S[S<4]!=1)
# 1.	S[S < 4]: This filters the elements in S where the condition S < 4 is TRUE. In other words, it keeps only those elements in S that are less than 4.

# 2.	mean(S[S < 4] != 1): Now that we have only 1s, 2s and 3s, we calculate the ratios of 2s and 3s

print(prob)

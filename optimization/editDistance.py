import sys
import functools

def computeEditDistance(s, t):
    @functools.cache
    def recurse(m, n):
        """
        Return the minimum edit distance between:
        - first m letters of s
        - first n letters of t
        """
        if m == 0:
            return n
        if n == 0:
            return m
        if s[m-1] == t[n-1]:
            return recurse(m-1, n-1)
        subCost = 1 + recurse(m-1, n-1)
        delCost = 1 + recurse(m-1, n)
        insCost = 1 + recurse(m, n-1)
        return min(subCost, delCost, insCost)
    return recurse(len(s), len(t))

print(computeEditDistance(sys.argv[1], sys.argv[2]))

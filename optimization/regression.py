def gradient_descent(dF, step_size=0.001, N=10**100000, TOL=0, w0=0):
    # x_n = x_{n-1} - step_size*gradient(f)
    w = w0
    for i in range(N):
        w = w-step_size*dF(w)
        if abs(w-w0) <= TOL:
            return w
        w0 = w
    return w
    

# Least Square problem
# min f(W) = sum (wx_i-y_i)^2

points = [(2,4), (4,2)]
# gradient(f) = sum(2x(wxi-y_i))
dF = lambda w: sum([2*x*(w*x-y) for x,y in points])
w = gradient_descent(dF, w0=0, step_size=0.01, N=100)
print(w)





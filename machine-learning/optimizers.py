import numpy as np

def stochastic_gradient_descent(F, dF, dataset, step_size=0.001, N=10**100000, TOL=0, w0=0, batch_size=32):
    # x_n = x_{n-1} - step_size*gradient(f)
    w = w0
    for i in range(N):
        np.random.shuffle(dataset)
        for sample in dataset:
            w = w-step_size*dF(w, sample)
        tol = np.linalg.norm(w-w0)
        print({'F': F(w), 'Weights': w, 'Tolerance': tol})
        if tol <= TOL:
            return w
        w0 = w
    return w

def gradient_descent(F, dF, step_size=0.001, N=10**100000, TOL=0, w0=0):
    # x_n = x_{n-1} - step_size*gradient(f)
    w = w0
    for i in range(N):
        w = w-step_size*dF(w)
        tol = np.linalg.norm(w-w0)
        print({'F': F(w), 'Weights': w, 'Tolerance': tol})
        if tol <= TOL:
            return w
        w0 = w
    return w

def newton_method(F, dF, d2F, step_size=0.001, N=10**100000, TOL=0, w0=0):
    # x_n = x_{n-1} - step_size*gradient(f)/hessian(f)
    w = w0
    for i in range(N):
        w = w-step_size*dF(w)/d2F(w)
        tol = np.linalg.norm(w-w0)
        print({'F': F(w), 'Weights': w, 'Tolerance': tol})
        if tol <= TOL:
            return w
        w0 = w
    return w






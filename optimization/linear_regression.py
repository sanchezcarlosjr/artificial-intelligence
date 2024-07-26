from optimizers import gradient_descent, stochastic_gradient_descent
import numpy as np

true_w = np.array([1,2,3,4,5])
d = len(true_w)
D_training = [(x:=np.random.randn(d), true_w.dot(x)+np.random.randn()) for w in range(100000)]

# batch_size in [1, len(D_training)]
def dF(w, point):
    x,y = point
    return 2*x*(w.dot(x)-y)

def F(w):
    return sum([(w.dot(x)-y)**2 for x,y in D_training]) / len(D_training)

stochastic_gradient_descent(F, dF, D_training, w0=np.zeros(d), TOL=0.1, step_size=0.01, N=10000)


#dF = lambda w: sum([2*x*(w.dot(x)-y) for x,y in D_training]) / len(D_training)
#w = gradient_descent(F, dF, w0=np.zeros(d), TOL=0, step_size=0.01, N=100000)

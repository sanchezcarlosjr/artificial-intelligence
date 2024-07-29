import numpy as np

def kmeans(data, k=3, max_iterations=100):
    centroids = np.random.rand(k, len(data[1]))
    for i in range(max_iterations):
        assigments = [np.argmin([np.linalg.norm(vector-centroid) for centroid in centroids]) for vector in data]
        centroids = np.array([np.mean([data[i] for i in range(len(data)) if assigments[i] == j], axis=0) for j in range(k)])
    return assigments


assert kmeans(np.array([[0, 0], [1,0], [0,1], [1,1], [5, 5], [5,6]]), k=2) == np.array([0,0,0,0,1,1])

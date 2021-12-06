import sys
import numpy as np


def read_input(f_name):
    out = []
    with open(f_name, 'r') as f:
        for line in f.readlines():
            temp = line.split(" = ")
            dist = temp[-1]
            places = temp[0].split(" to ")
            out.append((places, dist))
    idx = {e: i for i, e in enumerate(set([j for i in out for j in i[0]]))}
    np_out = np.zeros((len(idx), len(idx)))
    for places, dist in out:
        idx1 = idx[places[0]]
        idx2 = idx[places[1]]
        np_out[idx1, idx2] = dist
        np_out[idx2, idx1] = dist
    return np_out, idx


def run_dijkstra(np_out, source=0):
    current_vertex = source
    n = len(np_out)
    weights = np.array([np.inf if i != source else 0 for i in range(n)])
    unvisited = set([i for i in range(n)])
    vertices = []
    while len(unvisited) > 0:
        vertices.append(current_vertex)
        next_vertex = list(unvisited)[0]
        unvisited -= set([current_vertex])
        min_new = np.inf
        for i in unvisited:
            path = np_out[current_vertex, i]
            weights[i] = weights[current_vertex]+path
            if weights[i] < min_new:
                next_vertex = i
                min_new = weights[i]
            elif weights[i] == min_new:
                print(f"found equivalent options: {i}, {next_vertex}")
        current_vertex = next_vertex
    print(vertices, max(weights))
    return max(weights)


def find_minimum(np_out):
    return min(run_dijkstra(np_out, i) for i in range(len(np_out)))


def main(f_name):
    out, idx = read_input(f_name)
    print(find_minimum(out))


if __name__ == "__main__":
    main(sys.argv[1])

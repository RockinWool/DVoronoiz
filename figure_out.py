import networkx as nx
import matplotlib.pyplot as plt

def figure_out(G,pos,name):
    nx.draw_networkx_nodes(G, pos, node_size=20, node_color="b")
    nx.draw_networkx_edges(G, pos, width=1)
    plt.axis("off")
    plt.show()
    plt.savefig( '{}.png'.format(name))
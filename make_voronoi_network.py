import scipy.spatial as V
import numpy as np
import networkx as nx
import pandas as pd
import matplotlib.pyplot as plt
import figure_out as fout

def make_voronoi(number_of_points = 100):
    #--第一部：初期設定(maxvalueで決められた平面サイズに適当にnumber_of_node個の点をプロット)---#
    maxvalue = 100
    #--第二部：ボロノイ図の作成--#
    A=np.array([[np.random.rand()*maxvalue,np.random.rand()*maxvalue] for i in range(number_of_points)])
    vor = V.Voronoi(A)
    V.voronoi_plot_2d(vor,show_points = False)
    #V.voronoi_plot_2d(vor)
    plt.show()
    #print(vor.points)#元の点の座標
    #print(vor.vertices)#Voronoiの点の座標
    #print(vor.ridge_vertices)#Voronoiのリンク。-1が外部とのリンクを示す
    #print(vor.ridge_dict)#どの点とどの点が隣接しているかを辞書型で表示

    #--第三部：ネットワークグラフの作成 --#
    pos = vor.vertices
    illigal_points = []
    N = [i for i in range(len(pos))]
    for i in range(len(pos)):
        if(0 > pos[i][0] or maxvalue  < pos[i][0]):
            illigal_points.append(i)
        elif(0 > pos[i][1] or maxvalue  < pos[i][1]):
            illigal_points.append(i)
    G = nx.Graph()
    E = vor.ridge_vertices
    G.add_nodes_from(N)
    G.add_edges_from(E)
    G.remove_node(-1)
    G.remove_nodes_from(illigal_points)
    #pos = np.delete(pos,illigal_points,axis=0)
    
    #print(pos)pass
    #--第四部：グラフとposを返す--#
    #pos_g = pos
    data = [G,pos]
    fout.figure_out(G,pos,'Voronoiz')
    return(data)
    #return(G)

if  __name__ == "__main__":
    make_voronoi()
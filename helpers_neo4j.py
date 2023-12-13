import pandas as pd
from py2neo import Graph

uri="bolt://0.0.0.0:7687"
user='neo4j'
pwd=''
graph = Graph(uri, auth=(user, pwd))


# driver = GraphDatabase.driver(uri,auth=(user,pwd))
#--- Function to get all properties from all nodes as a datafrrame
# [py2neo]
# property names as column names

def get_node(graph, nodeLabel, verbose=True):
    query="MATCH (s:"+nodeLabel+") RETURN s"
    res = graph.run(query)
    res = [dict(i.get('s')) for i in res]
    df = pd.DataFrame(res)
    if verbose:
        print('\n\tquery: ',query)    
    return df
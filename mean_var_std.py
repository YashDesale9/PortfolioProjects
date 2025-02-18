import numpy as np

def calculate(arr):

    if len(arr) != 9:
        raise ValueError('List must contain nine numbers.')

    lst = np.array(arr)
    shp = lst.reshape(3,3)
    dict = {}
    
    mean_rows = list(shp.mean(axis=0)) 
    mean_col = list(shp.mean(axis=1))
    mean_mat = shp.mean()

    var_rows = list(shp.var(axis=0)) 
    var_col = list(shp.var(axis=1))
    var_mat = shp.var()

    std_rows = list(shp.std(axis=0)) 
    std_col = list(shp.std(axis=1))
    std_mat = shp.std()

    max_rows = list(shp.max(axis=0)) 
    max_col = list(shp.max(axis=1))
    max_mat = shp.max()

    min_rows = list(shp.min(axis=0)) 
    min_col = list(shp.min(axis=1))
    min_mat = shp.min()

    sum_rows = list(shp.sum(axis=0)) 
    sum_col = list(shp.sum(axis=1))
    sum_mat = shp.sum()

    dict['mean'] = [mean_rows, mean_col, mean_mat]
    dict['variance'] = [var_rows, var_col, var_mat]
    dict['standard deviation'] = [std_rows, std_col, std_mat]
    dict['max'] = [max_rows, max_col, max_mat]
    dict['min'] = [min_rows, min_col, min_mat]
    dict['sum'] = [sum_rows, sum_col, sum_mat]

    return dict
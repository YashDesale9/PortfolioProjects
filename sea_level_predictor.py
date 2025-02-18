import pandas as pd
import matplotlib.pyplot as plt
from scipy.stats import linregress

def draw_plot():
    # Read data from file
    df = pd.read_csv('epa-sea-level.csv')
    x = df['Year']
    y = df['CSIRO Adjusted Sea Level']


    # Create scatter plot
    fig,ax = plt.subplots()
    plt.scatter(x, y)


    # Create first line of best fit
    reg1 = linregress(x,y)
    x1 = range(df['Year'].min(), 2051)
    y1 = reg1.slope*x1+reg1.intercept
    plt.plot(x1, y1, 'r')


    # Create second line of best fit
    recent_data = df[df['Year']>=2000]
    reg2 = linregress(recent_data['Year'], recent_data['CSIRO Adjusted Sea Level'])
    x2 = range(2000, 2051)
    y2 = reg2.slope*x2+reg2.intercept
    plt.plot(x2, y2, 'r')


    # Add labels and title
    ax.set_xlabel('Year')
    ax.set_ylabel('Sea Level (inches)')
    ax.set_title('Rise in Sea Level')

    
    # Save plot and return data for testing (DO NOT MODIFY)
    plt.savefig('sea_level_plot.png')
    return plt.gca()
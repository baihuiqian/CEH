import matplotlib.pyplot as plt
import matplotlib as mpl
import cartopy.crs as ccrs
import numpy as np
import xarray as xr
import cmaps
from matplotlib.colors import BoundaryNorm
def main(sc):
	#set the model filenames
	project_dir = 'C:\\Users\hebai\\OneDrive - NERC\\uEMEP_project\\'
	uemep_dir =  project_dir+'data\\'
	#sc = '250m_base'
	variable = 'no2_concentration'
	# import data
	ds = xr.open_dataset(uemep_dir +"no2_ymean_Glasgow_"+sc+'.nc')
	dr = ds [variable]
	
	# parameters 
	crs = ccrs.UTM('30N')
	fig = plt.figure(figsize=[8, 4])
	ax = plt.gca(projection=crs)
	cmap = cmaps.WhiteBlueGreenYellowRed
	bounds = np.linspace(0, 80, 21) # 20+1 
	norm = mpl.colors.BoundaryNorm(bounds, cmap.N, clip = True)
	
	#plot
	img= plt.imshow(dr,cmap=cmap,norm=norm, transform=crs)
	ax.axes.xaxis.set_visible(False)
	ax.axes.yaxis.set_visible(False)
	plt.grid(True)
	plt.colorbar(extend='both')
	ax.set(title="NO$_2$ annual average concentration for Glasgow "+sc+ "($\mu$g/m$^3$) ")
	
	# output 
	plt.savefig(project_dir+'figs\\'+sc+'NO2.png', dpi=300) 
	plt.show()

#main('250m_base')
#main('250m_sc1')
#main('250m_sc2')
#main('250m_sc3')
main('sc4')
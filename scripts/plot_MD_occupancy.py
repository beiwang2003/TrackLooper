from __future__ import print_function
import plottery.plottery as ply
import ROOT as r
import numpy as np
import sys,os

filename = "../occupancy_studies/debug_all.root"
if len(sys.argv) > 1:
    filename = sys.argv[1]

#xaxis_range = [0,50] #SUBJECT TO CHANGE
folder_prefix = "/home/users/bsathian/public_html/SDL/SDL_Occupancies_20200407/SDL_MD_Occupancies_20200407/"

mdf = open("temp.md","w")
mdf.write("% Mini-doublet Occupancy summary\n")
mdf.write("### 99% of the distribution between lower and upper limits\n")
mdf.write("| Region | Lower limit &nbsp; &nbsp; | Upper limit &nbsp; &nbsp; | Link|\n")
mdf.write("| :---: | :---: | :---: | :---: |\n")

def plot_occupancy(hist,prefix):
    global folder_prefix
    filename_prefix = prefix.replace(" ","_")
    #Fancy way to find xaxis range
    nonzero_flag = False

    xaxis_range = [0,500]
    summary_upper_limit = -1
    ymax = 0
    for i in range(1,hist.GetNbinsX()-1):
        if hist.GetBinContent(i) != 0:
            if ymax < hist.GetBinContent(i):
                ymax = hist.GetBinContent(i)
            if i > 2 and nonzero_flag == False:
                xaxis_range[0] = hist.GetBinLowEdge(i-2)
            nonzero_flag = True
        if hist.GetBinContent(i) != 0 and hist.GetBinContent(i+1) == 0 and nonzero_flag == True:
            xaxis_range[1] = hist.GetBinLowEdge(i+2)

        if nonzero_flag and hist.Integral(0,i)/hist.Integral(0,-1) > 0.9999 and summary_upper_limit < 0:
            summary_upper_limit = hist.GetBinLowEdge(i+1)

    filename_prefix = folder_prefix +filename_prefix

    url = (filename_prefix+".pdf").replace("/home/users/bsathian/public_html/","http://uaf-10.t2.ucsd.edu/~bsathian/")

    if nonzero_flag == False :
        mdf.write("|{}|{}|{}|[plot]({})|\n".format(prefix,0,0,url))
    else:
        mdf.write("|{}|{}|{}|[plot]({})|\n".format(prefix,xaxis_range[0],summary_upper_limit,url))

    ply.plot_hist(
        bgs = [hist],
        legend_labels = [prefix],
        options = {
        "output_name":filename_prefix+".pdf",
        "xaxis_range":xaxis_range,
        "xaxis_label":prefix,
        "yaxis_log":True,
        "title":prefix,
        "yaxis_range":[0.1,ymax],
        "legend_percentageinbox":False,
        }
    )



f = r.TFile(filename)
layer_average_occupancy_hists = []
layer_occupancy_hists = []
layer_barrel_average_occupancy_hists = []
layer_barrel_occupancy_hists = []
layer_endcap_average_occupancy_hists = []
layer_endcap_occupancy_hists = []
ring_endcap_average_occupancy_hists = []
ring_endcap_occupancy_hists = []

for i in range(1,7):
    layer_average_occupancy_hists.append(f.Get("Root__average_MD_occupancy_in_layer_"+str(i)))
    layer_barrel_average_occupancy_hists.append(f.Get("Root__average_MD_occupancy_in_barrel_for_layer_"+str(i)))
    layer_endcap_average_occupancy_hists.append(f.Get("Root__average_MD_occupancy_in_endcap_for_layer_"+str(i)))

    layer_occupancy_hists.append(f.Get("Root__MD_occupancy_in_layer_"+str(i)))
    layer_barrel_occupancy_hists.append(f.Get("Root__MD_occupancy_in_barrel_for_layer_"+str(i)))
    layer_endcap_occupancy_hists.append(f.Get("Root__MD_occupancy_in_endcap_for_layer_"+str(i)))

for i in range(1,16):
    ring_endcap_average_occupancy_hists.append(f.Get("Root__average_MD_occupancy_in_endcap_for_ring_"+str(i)))
    ring_endcap_occupancy_hists.append(f.Get("Root__MD_occupancy_in_endcap_for_ring_"+str(i)))



barrel_occupancy_hist = f.Get("Root__MD_occupancy_in_barrel")
endcap_occupancy_hist = f.Get("Root__MD_occupancy_in_endcap")

barrel_average_occupancy_hist = f.Get("Root__average_MD_occupancy_in_barrel")
endcap_average_occupancy_hist = f.Get("Root__average_MD_occupancy_in_endcap")

plot_occupancy(barrel_occupancy_hist,"barrel mini-doublet occupancy")
plot_occupancy(endcap_occupancy_hist,"endcap mini-doublet occupancy")

plot_occupancy(barrel_average_occupancy_hist,"barrel average mini-doublet occupancy")
plot_occupancy(endcap_average_occupancy_hist,"endcap average mini-doublet occupancy")


for i in range(len(layer_occupancy_hists)):
    plot_occupancy(layer_occupancy_hists[i],"Mini-doublet Occupancy for layer "+str(i+1))
    plot_occupancy(layer_barrel_occupancy_hists[i],"Barrel Mini-doublet Occupancy for layer "+str(i+1))
    if i != 5:
        plot_occupancy(layer_endcap_occupancy_hists[i],"Endcap mini-doublet Occupancy for layer "+str(i+1))



for i in range(len(layer_average_occupancy_hists)):
    plot_occupancy(layer_average_occupancy_hists[i],"Average mini-doublet occupancy for layer "+str(i+1))
    plot_occupancy(layer_barrel_average_occupancy_hists[i],"Average barrel mini-doublet occupancy for layer "+str(i+1))
    if i!= 5:
        plot_occupancy(layer_endcap_average_occupancy_hists[i],"Average endcap mini-doublet occupancy for layer "+str(i+1))

for i in range(len(ring_endcap_average_occupancy_hists)):
    plot_occupancy(ring_endcap_average_occupancy_hists[i],"Average endcap mini-doublet occupancy in ring "+str(i+1))
    plot_occupancy(ring_endcap_occupancy_hists[i],"Endcap mini-doublet occupancy in ring "+str(i+1))

mdf.close()
os.system("sh ~/niceplots/niceplots.sh "+folder_prefix)
os.system("chmod -R 755 "+folder_prefix)
os.system("~/local/bin/pandoc temp.md -f markdown -t html -s -o {}/{}.html".format("~/public_html/SDL/SDL_Occupancies_20200407/summaries/","MD_summary"))

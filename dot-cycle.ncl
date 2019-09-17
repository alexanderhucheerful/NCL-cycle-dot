;***********************************
load "/work1/home/ysp/app/ncl/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "/work1/home/ysp/app/ncl/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
load "/work1/home/ysp/app/ncl/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "/work1/home/ysp/app/ncl/lib/ncarg/nclscripts/csm/contributed.ncl"
load "/work1/home/ysp/app/ncl/lib/ncarg/nclscripts/csm/shea_util.ncl"


begin
ascii_filename = "/work1/home/ouyanghx/grapes/analysis_fy3d_hiras/output/na15ama_2018091003/na15ama_2018091003_ambch005.txt"
argu  = asciiread(ascii_filename,(/936,10/),"float")
;436行

obs = argu(:,6)
lat=argu(:,2)
lon=argu(:,3)
olon = fspan(0,360,6470)
olat = fspan(-90,90,2513)

olon!0          = "lon"
olon@long_name  = "lon"
olon@units      = "degrees-east"
olon&lon        = olon
olat!0          = "lat"
olat@long_name  = "lat"
olat@units      = "degrees_north"
olat&lat        = olat
obs@_FillValue = 999999.000000
rscan = (/1/)   
dataobs = obj_anal_ic_Wrap(lon,lat,obs,olon,olat,rscan,False)
dataobs@units="K"

wks=gsn_open_wks("png", "hxss")
gsn_define_colormap(wks,"BlueDarkRed18")

res=True
res@gsnDraw=False
res@gsnFrame=False
;res@gsnAddCyclic=False
res@gsnMaximize=True
res@mpFillOn  = True
res@mpCenterLonF   =180      
res@mpMinLatF =-90
res@mpMaxLatF =90
res@mpMinLonF =0
res@mpMaxLonF =360
;res@mpDataBaseVersion="Ncarg4_1"
res@mpDataSetName="Earth..4"
res@mpAreaMaskingOn=True
;res@mpMaskAreaSpecifiers=(/"China","Taiwan","Arunachal Pradesh","Disputed area between India and China"/)
res@mpOceanFillColor=0
;res@mpInlandWaterFillColor=1
res@mpLandFillColor=0
res@mpOutlineOn=True
;res@mpOutlineSpecifiers=(/"China","Taiwan","Arunachal Pradesh","Disputed area between India and China"/)
;res@mpOutlineBoundarySets="NoBoundaries"

;res@gsnLeftString         = "CWF"
;res@gsnRightString        = "1961/62-2016/17"
plot=gsn_csm_map(wks, res)
dum=new((/936/), graphic)
;plot
res1=True
;res1@gsMarkerIndex=1
;res1@gsMarkerSizeF=0.008
;add
res1@sfXArray=lon
res1@sfYArray=lat
do i = 0, 935

if (obs(i).le.-0.5)then
res1@gsMarkerIndex=16
res1@gsMarkerSizeF=0.004
res1@gsMarkerColor=2
dum(i)=gsn_add_polymarker(wks, plot, lon(i), lat(i), res1)
end if

if (obs(i).gt.-0.5.and.obs(i).le.-0.4) then
res1@gsMarkerIndex=16
res1@gsMarkerSizeF=0.004
res1@gsMarkerColor=3
dum(i)=gsn_add_polymarker(wks, plot, lon(i), lat(i), res1)
end if

if (obs(i).gt.-0.4.and.obs(i).le.-0.3) then
res1@gsMarkerIndex=16
res1@gsMarkerSizeF=0.004
res1@gsMarkerColor=4
dum(i)=gsn_add_polymarker(wks, plot,lon(i), lat(i), res1)
end if

if (obs(i).gt.-0.3.and.obs(i).le.-0.2) then
res1@gsMarkerIndex=16
res1@gsMarkerSizeF=0.004
res1@gsMarkerColor=6
dum(i)=gsn_add_polymarker(wks, plot,lon(i), lat(i), res1)
end if

if (obs(i).gt.-0.2.and.obs(i).le.-0.1)then
res1@gsMarkerIndex=16
res1@gsMarkerSizeF=0.004
res1@gsMarkerColor=7
dum(i)=gsn_add_polymarker(wks, plot, lon(i), lat(i), res1)
end if

if (obs(i).gt.-0.1.and.obs(i).le.0)then
res1@gsMarkerIndex=16
res1@gsMarkerSizeF=0.004
res1@gsMarkerColor=9
dum(i)=gsn_add_polymarker(wks, plot, lon(i), lat(i), res1)
end if

if (obs(i).gt.0.and.obs(i).le.0.1)then
res1@gsMarkerIndex=16
res1@gsMarkerSizeF=0.004
res1@gsMarkerColor=12
dum(i)=gsn_add_polymarker(wks, plot, lon(i), lat(i), res1)
end if

if (obs(i).gt.0.1.and.obs(i).le.0.2)then
res1@gsMarkerIndex=16
res1@gsMarkerSizeF=0.004
res1@gsMarkerColor=14
dum(i)=gsn_add_polymarker(wks, plot, lon(i), lat(i), res1)
end if

if (obs(i).gt.0.2.and.obs(i).le.0.3)then
res1@gsMarkerIndex=16
res1@gsMarkerSizeF=0.004
res1@gsMarkerColor=15
dum(i)=gsn_add_polymarker(wks, plot, lon(i), lat(i), res1)
end if

if (obs(i).gt.0.3.and.obs(i).le.0.4)then
res1@gsMarkerIndex=16
res1@gsMarkerSizeF=0.004
res1@gsMarkerColor=17
dum(i)=gsn_add_polymarker(wks, plot, lon(i), lat(i), res1)
end if

if (obs(i).gt.0.4.and.obs(i).le.0.5)then
res1@gsMarkerIndex=16
res1@gsMarkerSizeF=0.004
res1@gsMarkerColor=18
dum(i)=gsn_add_polymarker(wks, plot, lon(i), lat(i), res1)
end if

if (obs(i).gt.0.5)then
res1@gsMarkerIndex=16
res1@gsMarkerSizeF=0.004
res1@gsMarkerColor=19
dum(i)=gsn_add_polymarker(wks, plot, lon(i), lat(i), res1)
end if
end do



;marker=(/16,16,16,16,16,16,16,16,16,16,16,16/)
color=(/2,3,4,6,7,9,   12,14,15,17,18,19/)
label= (/"=--0.5","-0.5--0.4","-0.4--0.3","-0.3--0.2","-0.2--0.1","-0.1-0","0-0.1","0.1-0.2","0.2-0.3","0.3-0.4","0.4-0.5","0.5-"/)
levels  = (/   -0.5, -0.4, -0.3, -0.2, -0.1, 0, 0.1, 0.2, 0.3, 0.4, 0.5 /)  
nlevels = dimsizes(levels)
        labels  = new(nlevels,string)
        labels       = sprintf("%4.1f",levels)   ; Format the labels
;size=(/0.004,0.004,0.004,0.004,0.004,0.004,0.004,0.004,0.004,0.004,0.004,0.004/)                  
;xleg=0.88
;xtxt=0.93
;y=fspan(0.25,0.85,20)
;gsres                       =True
;gsres@gsMarkerSizeF         =0.012
;gsres@gsMarkerThicknessF    =0.5
;txres                       =True
;txres@txFontHeightF         =0.012
;gsres@gsMarkerThicknessF    =0.5
;do i=0,11
;    gsres@gsMarkerIndex=marker(i)
;    gsres@gsMarkerColor=color(i)
;    gsres@gsMarkerSizeF=size(i)
;    gsn_polymarker_ndc(wks, xleg, y(11-i), gsres)
;    gsn_text_ndc(wks, label(i), xtxt, y(11-i), txres)
;end do            
lbres                           = True
        lbres@lbAutoManage              = False         ; we control label bar
        lbres@vpWidthF           = 0.7
        lbres@vpHeightF          = 0.1

        lbres@lbFillColors              = color   ; use nice strided colors
        lbres@lbPerimOn                 = False         ; Turn off labelbar perimeter.
        lbres@lbMonoFillPattern         = True          ; one pattern, all solid
        lbres@lbOrientation      = "Horizontal"
        lbres@lbLabelAlignment="InteriorEdges"
        lbres@lbLabelFont=25
        lbres@lbLabelFontHeightF = 0.015
        lbres@lbLabelStrings       = sprintf("%4.1f",levels)   ; Format the labels
        lbres@lbLabelStride=1
;lbres@pmLabelBarOrthogonalPosF  = -5
        nboxes=dimsizes(labels)+1
        clabels       = sprintf("%4.1f",levels)   ; Format the labels
        gsn_labelbar_ndc(wks,nboxes,clabels,0.155,0.175,lbres)
    

draw(plot)
  frame(wks) 

end

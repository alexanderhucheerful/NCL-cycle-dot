 load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
 load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
 load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
 load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"
 load "/work1/home/ysp/app/ncl/lib/ncarg/nclscripts/csm/gsn_code.ncl"
 load "/work1/home/ysp/app/ncl/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
 begin
;*****************************************
; writen by ouyanghongxiang 2019-9-28
; Purpse: to read NCEP 
;         to draw picture
;
;*****************************************
hx=addfile("/work1/home/ouyanghx/ncep/hgt.mon.mean.nc","r")
hgta=hx->hgt(0:851,:,:,:)
hgt1=clmMonTLLL(hgta)
hgtdj1=month_to_season(hgt1,"JFM")
hgtxj1=month_to_season(hgt1,"JAS")
hgt200dj=hgtdj1(0,{200},:,:)
hgt850dj=hgtdj1(0,{850},:,:)
hgt200xj=hgtxj1(0,{200},:,:)
hgt850xj=hgtxj1(0,{850},:,:)
;*****************************************
;creat plot
;*****************************************
  wks_type = "png"
  wks_type@wkWidth = 2400
  wks_type@wkHeight = 2400
  wks1 = gsn_open_wks(wks_type,"hgt200dj")
  wks2 = gsn_open_wks(wks_type,"hgt850dj")
  wks3 = gsn_open_wks(wks_type,"hgt200xj")
  wks4 = gsn_open_wks(wks_type,"hgt850xj")
gsn_define_colormap(wks1,"BlueRed");lengnuanse
gsn_define_colormap(wks2,"BlueRed");lengnuanse
gsn_define_colormap(wks3,"BlueRed");lengnuanse
gsn_define_colormap(wks4,"BlueRed");lengnuanse
  res                       = True
  res@gsnMaximize           = True
  res@gsnDraw               = False
  res@gsnFrame              = False
  res@mpFillOn              = True     ; turn on color fill
  res@mpCenterLonF   =180
  ;res@_Fillvalue=-9.96921e+36
  ;levels  = (/ 10500, 10650, 10800, 10950, 11100, 11250, 11400, 11550, 11700, 11850, 12000, 12150, 12300, 12450, 12600 /)
  ;colors=(/2,3,4,5,6,7,8,12,13,14,15,16,17/);lengnuanse
  ;res@cnLevelSelectionMode = "ManualLevels"
  ;res@cnLevelSelectionMode = "EXPLICITLEVELS"
  ;res@cnLevels             = levels
  res@cnExplicitLineLabelsOn = True
  ;res@cnLineLabelStrings   = levels
  ;res@cnFillColors         = colors
  res@mpNationalLineColor        = "black"
  res@mpProvincialLineColor      = "black"
  res@mpGeophysicalLineColor     = "black"
  res@mpNationalLineThicknessF   = 2
  res@mpProvincialLineThicknessF = 1
  res@cnFillOn              = True
 ; res@cnFillpalette="NCV_blu_red"
  res@cnLineLabelsOn        = False
  res@cnLinesOn             = False    ; turn of contour lines
  res@lbLabelAutoStride          = True
  res@lbLabelFont =25
  ;res@pmLabelBarWidthF     =0.6
  res@pmLabelBarHeightF     =0.08
  res@pmLabelBarOrthogonalPosF = .15
  res@lbBoxLinesOn          =False
  res@tmYLMode       = "Explicit"
  res@tmYLValues     = (/-90,-60,-30,0,30,60,90/) ; major tm
  res@tmYLLabels     = (/"90S","60S","30S","EQ","30N","60N","90N"/)
  res@tmXBMode       = "Explicit"
  res@tmXBValues     = (/0,60,120,180,240,300,360/) ; major tm
  res@tmXBLabels     = (/"0","60E","120E","180","120W","60W","0"/)
  res@tmBorderThicknessF          = 10.
  res@tmXBMajorThicknessF         = 8.
  res@tmYLMajorThicknessF         = 8.
  res@tmXBMinorThicknessF         = 5.
  res@tmYLMinorThicknessF         = 5.
  res@mpMinLatF      = -90
  res@mpMaxLatF      = 90
  res@mpMinLonF      = 0
  res@mpMaxLonF      = 360
  res@cnMinLevelValF  = -0.6;oyhx set the minimum contour level
  res@cnMaxLevelValF  = 0.6;oyhx set the maximum contour level
  res@tmXBLabelFontHeightF = 0.014
  res@tmYLLabelFontHeightF  = 0.014
  res@tmXBLabelDeltaF = -0.6
  res@tmYLLabelDeltaF = -0.6
  res@tmYLLabelFont = 25
  res@tmXBLabelFont = 25
  res@lbLabelFont = 25
  res@cnLineLabelFont=25
  res@tmXTOn =False
  res@tmYROn =False
  res@tmBorderThicknessF = 8.
  res@tmXBMajorThicknessF = 4.
  res@tmXTMajorThicknessF = 4.
  res@tmYLMajorThicknessF = 4.
  res@tmYRMajorThicknessF = 4.
  res@tmXBMinorThicknessF = 3.
  res@tmXTMinorThicknessF = 3.



  res1                       = True
  res1@gsnMaximize           = True
  res1@gsnDraw               = False
  res1@gsnFrame              = False
  res1@mpFillOn              = True     ; turn on color fill
  res1@mpCenterLonF   =180
  ;levels2  = (/ 120, 122.5, 125, 127.5, 130, 132.5, 135, 137.5, 140, 142.5, 145, 147.5, 150, 152.5, 155, 157.5 /)
  ;colors=(/2,3,4,5,6,7,8,12,13,14,15,16,17/);lengnuanse
  ;res1@cnLevelSelectionMode = "ManualLevels"
  ;res1@cnLevels             = levels2
  res1@cnExplicitLineLabelsOn = True
  ;res1@cnLineLabelStrings   = levels2
  ;res1@cnFillColors         = colors
  res1@mpNationalLineColor        = "black"
  res1@mpProvincialLineColor      = "black"
  res1@mpGeophysicalLineColor     = "black"
  res1@mpNationalLineThicknessF   = 2
  res1@mpProvincialLineThicknessF = 1
  res1@cnFillOn              = True
  ;res1@cnFillpalette="NCV_blu_red"
  res1@cnLineLabelsOn        = False
  res1@cnLinesOn             = False    ; turn of contour lines
  res1@lbLabelAutoStride          = True
  res1@lbLabelFont =25
  ;res1@pmLabelBarWidthF     =0.6
  res1@pmLabelBarHeightF     =0.08
  res1@pmLabelBarOrthogonalPosF = .15
  res1@lbBoxLinesOn          =False
  res1@tmYLMode       = "Explicit"
  res1@tmYLValues     = (/-90,-60,-30,0,30,60,90/) ; major tm
  res1@tmYLLabels     = (/"90S","60S","30S","EQ","30N","60N","90N"/)
  res1@tmXBMode       = "Explicit"
  res1@tmXBValues     = (/0,60,120,180,240,300,360/) ; major tm
  res1@tmXBLabels     = (/"0","60E","120E","180","120W","60W","0"/)
  res1@tmBorderThicknessF          = 10.
  res1@tmXBMajorThicknessF         = 8.
  res1@tmYLMajorThicknessF         = 8.
  res1@tmXBMinorThicknessF         = 5.
  res1@tmYLMinorThicknessF         = 5.
  res1@mpMinLatF      = -90
  res1@mpMaxLatF      = 90
  res1@mpMinLonF      = 0
  res1@mpMaxLonF      = 360
  res1@cnMinLevelValF  = -0.6;oyhx set the minimum contour level
  res1@cnMaxLevelValF  = 0.6;oyhx set the maximum contour level
  res1@tmXBLabelFontHeightF = 0.014
  res1@tmYLLabelFontHeightF  = 0.014
  res1@tmXBLabelDeltaF = -0.6
  res1@tmYLLabelDeltaF = -0.6
  res1@tmYLLabelFont = 25
  res1@tmXBLabelFont = 25
  res1@lbLabelFont = 25
  res1@cnLineLabelFont=25
  res1@tmXTOn =False
  res1@tmYROn =False
  res1@tmBorderThicknessF = 8.
  res1@tmXBMajorThicknessF = 4.
  res1@tmXTMajorThicknessF = 4.
  res1@tmYLMajorThicknessF = 4.
  res1@tmYRMajorThicknessF = 4.
  res1@tmXBMinorThicknessF = 3.
  res1@tmXTMinorThicknessF = 3.

  plot1=gsn_csm_contour_map(wks1,hgt200dj,res)
  plot2=gsn_csm_contour_map(wks2,hgt850dj,res1)
  plot3=gsn_csm_contour_map(wks3,hgt200xj,res)
  plot4=gsn_csm_contour_map(wks4,hgt850xj,res1)
;mmp=True
;mmp@gsnPanelLabelBar=True
;gsn_panel(wks,(/plot2,plot4/),res1)
  draw(plot1)
  frame(wks1)
  draw(plot2)
  frame(wks2)
  draw(plot3)
  frame(wks3)
  draw(plot4)
  frame(wks4)

end




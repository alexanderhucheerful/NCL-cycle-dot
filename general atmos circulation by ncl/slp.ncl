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
hx=addfile("/work1/home/ouyanghx/ncep/slp.mon.mean.nc","r")
slpa=hx->slp(0:851,:,:)
slp1=clmMonTLL(slpa)
slpdj1=month_to_season(slp1,"JFM")
slpxj1=month_to_season(slp1,"JAS")
slpdj=slpdj1(0,:,:)
slpxj=slpxj1(0,:,:)

;*****************************************
;creat plot
;*****************************************
  wks_type = "png"
  wks_type@wkWidth = 2400
  wks_type@wkHeight = 2400
  wks1 = gsn_open_wks(wks_type,"slpdj")
  wks2 = gsn_open_wks(wks_type,"slpxj")
gsn_define_colormap(wks1,"BlueRed");lengnuanse
gsn_define_colormap(wks2,"BlueRed");lengnuanse

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

  plot1=gsn_csm_contour_map(wks1,slpdj,res)
  plot2=gsn_csm_contour_map(wks2,slpxj,res)

;mmp=True
;mmp@gsnPanelLabelBar=True
;gsn_panel(wks,(/plot2,plot4/),res1)
  draw(plot1)
  frame(wks1)
  draw(plot2)
  frame(wks2)

end




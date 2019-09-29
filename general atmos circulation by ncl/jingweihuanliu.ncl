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
hx=addfile("/work1/home/ouyanghx/ncep/uwnd.mon.mean.nc","r")
hx1=addfile("/work1/home/ouyanghx/ncep/vwnd.mon.mean.nc","r")
u=hx->uwnd(0:851,:,:,:)
v=hx1->vwnd(0:851,:,:,:)
u1=clmMonTLLL(u)
v1=clmMonTLLL(v)
udj1=month_to_season(u1,"JFM")
uxj1=month_to_season(u1,"JAS")
vdj1=month_to_season(v1,"JFM")
vxj1=month_to_season(v1,"JAS")
udj200=udj1(0,{200},:,:)
udj850=udj1(0,{850},:,:)
uxj200=uxj1(0,{200},:,:)
uxj850=uxj1(0,{850},:,:)
vdj200=vdj1(0,{200},:,:)
vdj850=vdj1(0,{850},:,:)
vxj200=vxj1(0,{200},:,:)
vxj850=vxj1(0,{850},:,:)
;*****************************************
;creat plot
;*****************************************
  wks_type = "png"
  wks_type@wkWidth = 2400
  wks_type@wkHeight = 2400
  wks1 = gsn_open_wks(wks_type,"uv200dj")
  wks2 = gsn_open_wks(wks_type,"uv200xj")
  wks3 = gsn_open_wks(wks_type,"uv850dj")
  wks4 = gsn_open_wks(wks_type,"uv850xj")
gsn_define_colormap(wks1,"BlueRed");lengnuanse
gsn_define_colormap(wks2,"BlueRed");lengnuanse
gsn_define_colormap(wks3,"BlueRed");lengnuanse
gsn_define_colormap(wks4,"BlueRed");lengnuanse
  res                       = True
  res@gsnLeftString  =""
  res@gsnRightString =""
  res@pmTickMarkDisplayMode = "Always"
  res@vcGlyphStyle = "FillArrow"
  res@vcFillArrowEdgeColor = "white"
  res@vcFillArrowFillColor = "black"
  res@vcMinMagnitudeF = 5.0
  res@vcMinDistanceF = 0.02
  res@vcFillArrowMinFracWidthF=1.0
  res@vcFillArrowHeadMinFracXF=1.0
  res@vcFillArrowHeadMinFracXF=1.0
  res@vcRefAnnoOn=True
  res@vcRefMagnitudeF = 20
  res@vcRefLengthF = 0.04
  res@vcRefAnnoBackgroundColor="white"
  res@vcRefAnnoPerimOn=False
  res@vcRefAnnoFontHeightF=0.015
  res@vcRefAnnoString1On=False
  res@vcRefAnnoString2On=True
  res@vcRefAnnoString2="20m/s"
  res@vcRefAnnoOrthogonalPosF=-1.25




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
  plot1=gsn_csm_vector_map(wks1,udj200,vdj200,res)
  plot2=gsn_csm_vector_map(wks2,uxj200,vxj200,res)
  plot3=gsn_csm_vector_map(wks3,udj850,vdj850,res)
  plot4=gsn_csm_vector_map(wks4,uxj850,vxj850,res)


end




 load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
 load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
 load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
 load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"
 load "/work1/home/ysp/app/ncl/lib/ncarg/nclscripts/csm/gsn_code.ncl"
 load "/work1/home/ysp/app/ncl/lib/ncarg/nclscripts/wrf/WRFUserARW.ncl"
 begin
;*****************************************
; writen by ouyanghongxiang 2019-9-22
; Purpse: to read MODIS-35  HDF 
;         to draw picture
;
;*****************************************
;Bit fields within each byte are numbered from the left: 
;7, 6, 5, 4, 3, 2, 1, 0.                                                 
;The left-most bit (bit 7) is the most significant bit.                  
;The right-most bit (bit 0) is the least significant bit.                
;                                                                            
;bit field    Description                        Key                     
;---------    -----------                        ---                     
;2, 1         Unobstructed FOV Quality Flag    00 (0) = Cloudy           
;                                              01 (1) = Uncertain        
;                                              10 (2) = Probably  Clear  
;                                              11 (3) = Clear  
;*****************************************
;           Read HDF files
;*****************************************


files = systemfunc("ls /work1/home/ouyanghx/grapes/prepropress/MODHDF/20190101/MOD*")
    do k=1,142
    in=addfile(files(k),"r")
    hx=addfile("/work1/home/ouyanghx/grapes/prepropress/MODHDF/20190101/MOD35_L2.A2019001.0000.061.2019001132013.hdf","r")

;****************************************
;          Time & Geographic
;****************************************


    lat2d=in->Latitude
    lon2d=in->Longitude
    ;lat@units = "degrees_north"             ; add units
    ;lon@units = "degrees_east"
    cldmsk=in->Cloud_Mask(0,:,:)
    
;******************************************************************
; Latitude/Longitude arrays are every 5km. Cloud_Mask is every 1km
; It is necessary to decimate the Cloud_Mask to match lat/lon
;******************************************************************
  dimcm  = dimsizes(cldmsk)
  NY     = dimcm(0)                  ; "along"  swath  [1 km]
  MX     = dimcm(1)                  ; "across" swath  [1 km]
  cm     = cldmsk(4:NY-1:5,4:MX-1:5) ; decimate to match lat2d/lon2d dimsizes
  delete(cldmsk)                     ; no longer needed
 
;******************************************************************
; extract the desired bits and attach lat/lon arrays
; cmfov = 00 [0] cloudy          ; 01 [1] uncertain 
;         10 [2] probably clear  ; 00 [3] confidently clear
;******************************************************************
  dimll  = dimsizes(lat2d)
  ny     = dimll(0)                  ; "along"  swath  [5 km]
  mx     = dimll(1)                  ; "across" swath  [5 km]
                                     ; extract bit pair
  tmp    = dim_gbits(ndtooned(cm),5,2,6,ny*mx) ; flagS
  cmfov  = onedtond(tmp, (/ny,mx/))  ; flags

  cmfov@lat2d = lat2d                ; attach 5km lat/lon info
  cmfov@lon2d = lon2d                ; lat2d, lon2d are *reserved* attributes
  
  
  
  
  
  
  
  
  lat1d=hx->Latitude
    lon1d=hx->Longitude
    ;lat@units = "degrees_north"             ; add units
    ;lon@units = "degrees_east"
    cldmsk1=hx->Cloud_Mask(0,:,:)
    
;******************************************************************
; Latitude/Longitude arrays are every 5km. Cloud_Mask is every 1km
; It is necessary to decimate the Cloud_Mask to match lat/lon
;******************************************************************
  dimcm  = dimsizes(cldmsk1)
  NY1     = dimcm(0)                  ; "along"  swath  [1 km]
  MX1     = dimcm(1)                  ; "across" swath  [1 km]
  cm1    = cldmsk1(4:NY1-1:5,4:MX1-1:5) ; decimate to match lat2d/lon2d dimsizes
  delete(cldmsk1)                     ; no longer needed
 
;******************************************************************
; extract the desired bits and attach lat/lon arrays
; cmfov1 = 00 [0] cloudy          ; 01 [1] uncertain 
;         10 [2] probably clear  ; 00 [3] confidently clear
;******************************************************************
  dimll  = dimsizes(lat1d)
  ny1     = dimll(0)                  ; "along"  swath  [5 km]
  mx1     = dimll(1)                  ; "across" swath  [5 km]
                                     ; extract bit pair
  tmp1    = dim_gbits(ndtooned(cm),5,2,6,ny1*mx1) ; flagS
  cmfov1  = onedtond(tmp, (/ny1,mx1/))  ; flags

  cmfov1@lat1d = lat1d                ; attach 5km lat/lon info
  cmfov1@lon1d = lon1d                ; lat2d, lon2d are *reserved* attributes
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  

;******************************************************************
; create plot
;******************************************************************
  ;wks = gsn_open_wks("png" ,"hdf4eos")          ; send graphics to PNG file
  wks_type = "png"
  wks_type@wkWidth = 2400
  wks_type@wkHeight = 2400
  wks = gsn_open_wks(wks_type,"hdf4eos")
  
  map=new(143,graphic)
;******************************************************************
 ; mkres = True
 ; mkres@gsnFrame = False
 ; mkres@gsnMaximize = True
 ; mkres@tiMainFontHeightF = 0.015
 ; mkres@mpFillOn  =False
 ; mkres@mpMaxLonF=180.0
 ; mkres@mpMinLonF=-180.0
 ; mkres@mpMaxLatF     = 90
 ; mkres@mpMinLatF     = -90
 ; mkres@tmYLTickSpacingF=30.0
 ; mkres@tmXBTickSpacingF=60.0
 ; mkres@tmXBMajorLengthF = 0.008
 ; mkres@tmYLMajorLengthF = 0.008
 ; mkres@mpGeophysicalLineThicknessF= 1.0 
 ; mkres@mpGeophysicalLineColor     = "black";
 ; mkres@tmXBLabelFont = 25   ;times new roman
 ; mkres@tmYLLabelFont = 25
 ; mkres@tmXBLabelFontHeightF = 0.014
 ; mkres@tmYLLabelFontHeightF = 0.014
 ; mkres@tmXBLabelDeltaF=-0.45
 ; mkres@tmYLLabelDeltaF=-0.45
 ; mkres@mpOutlineBoundarySets= "GeophysicalAndUSStates"
 ;mkres@mpShapeMode="FreeAspect"
 ;mkres@vpWidthF  = 0.7  ; Set width and height of plot.
 ;mkres@vpHeightF = 0.2
 ;mkres@tiMainString="Pair 9, 452hPa"
 ;mkres@tiMainFontHeightF=0.013
 ;mkres@tiMainFont=25
 ; colors=(/12,18,26,34,66,83,92,100,127,140,162,180/)
 ; map(1) = gsn_csm_map(wks,mkres)
  
 ; gsn_merge_colormaps(wks,"BlAqGrYeOrReVi200","nice_gfdl")
  colors = (/"gray"                    \        ; cloudy
            ,"red"                     \        ; uncertain
            ,"green"                   \        ; probably clear
            ,"white"                   /)       ; clear

  res                      = True     ; plot mods desired
;;res@gsnMaximize          = True     ; uncomment to maximize plot
  res@gsnAddCyclic         = False    ; data not cyclic

  res@cnFillOn             = True          ; turn on color fill
  res@cnFillPalette        = colors        ; set color map
  res@cnLinesOn            = False         ; turn on contour lines
  res@cnFillMode           = "RasterFill"  ; turn on raster mode

  res@cnLevelSelectionMode = "ManualLevels"     ; set manual contour levels
  res@cnMinLevelValF       =   1                ; set min contour level
  res@cnMaxLevelValF       =   3                ; one less than max
  res@cnLevelSpacingF      =   1                ; set contour spacing

  res@trGridType           = "TriangularMesh"   ; *faster* graphic rendering

  res@lbLabelStrings       = ispan(0,3,1)       ; 0, 1, 2, 3
  res@lbLabelPosition      = "Center"           ; label position
  res@lbLabelAlignment     = "BoxCenters"

  res@lbTitleString        = "0=cldy, 1=uncertain, 2=prob clr, 3=clr"
  res@lbTitlePosition      = "Bottom"
  res@lbTitleFontHeightF   = 0.0125             ; default 0.025

  ;res@mpProjection         = "Satellite" ; choose map projection
  res@mpFillOn             = False              ; turn off map fill
  res@mpCenterLonF         = (min(lon2d)+max(lon2d))*0.5
  ;res@mpCenterLatF         = (min(lat2d)+max(lat2d))*0.5

  res@mpLimitMode          = "LatLon"           ; required
  res@mpMinLatF            = -90;min(lat2d)-1       ; min lat
  res@mpMaxLatF            = 90;max(lat2d)+1       ; max lat
  res@mpMinLonF            = -180;min(lon2d)-1       ; min lon
  res@mpMaxLonF            = 180;max(lon2d)+1       ; max lon

  ;res@mpOutlineBoundarySets= "National"
  ;res@pmTickMarkDisplayMode= "Always"           ; turn on automatic tickmarks

res@gsnFrame                   = False
  res@tiMainString         = "Unobstructed FOV Quality Flag"
  ;res@gsnCenterString      = "MOD35_L2.A2019001.0000.061.2019001132013.hdf"

 ;map  = gsn_csm_contour_map(wks, cmfov, res)   ; map
  plot = gsn_csm_contour_map_overlay(wks,cmfov1,cmfov,res,res)
  draw(plot)
 ; plot=gsn_csm_contour(wks,cmfov,res)
 ; overlay(map(1),plot)
 ; draw(map(1))
    ;sate=new((/dimsizes(lat),3/),"float")
    ;sate(:,0)=lat
    ;sate(:,1)=lon
    ;sate(:,2)=obs
;opt=True
;opt@fout="MODIS.txt"
 ;write_matrix(sate, "3f15.5", opt)
; frame(wks)
;****************************************
delete(lat2d)
delete(lon2d)
delete(cm)
delete(tmp)
delete(cmfov)
end do 
delete(lat1d)
delete(lon1d)
delete(cm1)
delete(tmp1)
delete(cmfov1)
frame(wks)
end 

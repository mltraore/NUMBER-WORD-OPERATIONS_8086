
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
 
 
 
 
                                                          
;****************     YENI KATAR YAZMAYA YARAYAN MAKRO    ********************;
                         ;  STRING_YAZ MAKROSU ;
;        BU MAKRO EKRANA YENI BIR KATAR YAZDIRMAYA YARAMAKTADIR               ;

;*****************************************************************************;                                                              
STRING_YAZ  MACRO  string         ;MAKRO TANIMLANDI 
            push ax               ;AX'IN DEGERI KABETMEMEK ICIN STACK'E ATILDI 
            push dx               ;AX'IN DEGERI KABETMEMEK ICIN STACK'E ATILDI
            mov  ah , 09h         ;KATAR ALMA FONKSIYONU SECILDI
            lea  dx , string      ;PARAMETRE OLARAK ALINAN KATARIN ADRESI DX'E YUKLENDI
            int  21h              ;KATAR FONKSIYONUN BULUNDUGU INTERRUPT SECILDI
            pop  dx               ;STACK'TEN DX'IN DEGERI GERI ALINDI
            pop  ax               ;STACK'TEN DX'IN DEGERI GERI ALINDI
ENDM                              ;MAKRO SONLANDIRILDI
  
  
  
;*************** UC BASAMAKLI SAYIYI YAZIYA DONUSTUREN MAKRO *****************;
                        
                        ;  CEVIR MAKROSU  ;      
                              
;       BU MAKRO UC BASAMAKLI SAYILARI KATAR ADRESINI ALARAK 
;       YAZIYA DONUSTERMEYE YARAYAN BIR MAKRODUR.
;       KULLANICI DAN ALINAN SAYI BASAMAK SAYISINA GÖRE UC BASAMAKLARA
;       AYRILIR VE HER UC BASAMAKLI SAYI BU MAKRO ILE YAZIYA DONUSTURULUR
;       ORNEK OLARAK OLARAK 12100 ICIN ONCE 12 VE 300 OLARAK ALINIR
;       ILK OLARAK BU MAKRO CAGIRARAK 12 ALINIR VE CEVIRILIR "ON IKI"
;       VE "ON IKI" YAZISI  "YAZIYACEVIR" ETIKETINDE BIN EKLENIR
;       TOPLAM BES BASAMAKLI OLDUGUNDAN DOLAYI VE ON IKI BIN BULUNUR
;       SONRADAN BU MAKROYA 300 KATAR ADRESINI ATANIR VE CEVIRILIR 
;       TEKRAR  "YAZIYACEVIR" ETIKETINDE KULLANILIR VE ON IKI BIN UC YUZ 
;       YAZDIRILIR.    

;****************************************************************************; 

CEVIR MACRO address               ;MAKRO TAMIMLANDI
                                  ;LOCAL BASLIKLI SATIRLAR , MAKRO ICINDE KULLANILAN ETIKETLERI LOKAL OLARAK TANIMLANDI  
                                  ;"DUPLICATE LABEL HATASINI ONLER" 
    
    LOCAL DONGU , ATLA , UCBASAMAK , IKIBASAMAK , BIRBASAMAK 
    LOCAL _000, _100 , _200 , _300 , _400 , _500 , _600 , _700 , _800 , _900 
    LOCAL _00 , _10 , _20 , _30 , _40 , _50 , _60 , _70 , _80 , _90
    LOCAL _1 , _2 , _3 , _4 , _5 , _6 , _7 , _8 , _9
    
         mov  di , address        ;PARAMETRE OLARAK ALINAN ADRES DI' YE YUKLENDI
         push cx                  ;CX' IN DEGERI STACK' E ATILDI
         mov  cx , bx             ;BX' ADRESI CX' E YUKLENDI
    DONGU:                        ;DONGU  ETIKETI        
         CMP CX , 3               ;CX' IN ICINDEKI DEGERI 3 ILE KIYASLANDI
         JE  UCBASAMAK            ;3 ISE UCBASAMAK ETIKETINE DALLAN
         CMP CX , 2               ;CX' IN ICINDEKI DEGERI 2 ILE KIYASLANDI
         JE  IKIBASAMAK           ;2 ISE UCBASAMAK ETIKETINE DALLAN
         CMP CX , 1               ;CX' IN ICINDEKI DEGERI 1 ILE KIYASLANDI
         JE  BIRBASAMAK           ;1 ISE UCBASAMAK ETIKETINE DALLANDI
         
     UCBASAMAK:                   ;UC BASAMAKLI SAYI ISE DALLANAN ETIKET
         CMP  [DI] , 0            ;[DI] BELLEK GOZUNDEKI DEGERI O ILE KIYASLANDI 
         JE  _000                 ;0 ISE _000 ETIKETINE DALLANDI         
         CMP  [DI] , 1            ;[DI] BELLEK GOZUNDEKI DEGERI 1 ILE KIYASLANDI
         JE   _100                ;1 ISE _100 ETIKETINE DALLANDI
         CMP  [DI] , 2            
         JE   _200                
         CMP  [DI] , 3            
         JE   _300                
         CMP  [DI] , 4         
         JE   _400               
         CMP  [DI] , 5           
         JE   _500                
         CMP  [DI] , 6          
         JE   _600                
         CMP  [DI] , 7            
         JE   _700                
         CMP  [DI] , 8            
         JE   _800                
         CMP  [DI] , 9            ;[DI] BELLEK GOZUNDEKI DEGERI 9 ILE KIYASLANDI
         JE   _900                ;9 ISE _900 ETIKETINE DALLANDI
     
         _000:                    ;_000 ETIKETI
         JMP ATLA                 ;ATLA ETIKETINE DALLANDI
         _100:                    ;_100 ETIEKTI
         STRING_YAZ yuz           ;EKRANA YUZ YAZDIRILDI 
         JMP ATLA                 ;ATLA' YA DALLANDI     
         _200:                    ;_200 ETIKETI
         STRING_YAZ iki           ;EKRANA IKI YAZDIRILDI
         STRING_YAZ yuz           ;EKRANA YUZ YAZDIRILDI
         JMP ATLA                 ;ATLAYA DALLANDI
         _300:                    
         STRING_YAZ uc            
         STRING_YAZ yuz           
         JMP ATLA                 
         _400:
         STRING_YAZ dort
         STRING_YAZ yuz         
         JMP ATLA 
         _500:
         STRING_YAZ bes
         STRING_YAZ yuz   
         JMP ATLA 
         _600:
         STRING_YAZ alti
         STRING_YAZ yuz   
         JMP ATLA 
         _700:
         STRING_YAZ yedi
         STRING_YAZ yuz 
         JMP ATLA 
         _800:
         STRING_YAZ sekiz
         STRING_YAZ yuz   
         JMP ATLA 
         _900:                    ;_900 ETIKETI
         STRING_YAZ dokuz         ;EKRANA DOKUZ YAZDIRILDI
         STRING_YAZ yuz           ;EKRANA YUZ YAZDIRILDI
         JMP ATLA                 ;ATLAYA DALLANDI
                 
     IKIBASAMAK:                  ;IKI BASAMAKLI SAYI ISE DALLANAN ETIKET
         CMP  [DI] , 0            ;[DI] BELLEK GOZUNDEKI DEGERI O ILE KIYASLANDI
         JE  _00                  ;0 ISE _00 ETIKETINE DALLANDI
         CMP  [DI] , 1 
         JE   _10
         CMP  [DI] , 2  
         JE   _20
         CMP  [DI] , 3  
         JE   _30
         CMP  [DI] , 4  
         JE   _40
         CMP  [DI] , 5  
         JE   _50
         CMP  [DI] , 6  
         JE   _60
         CMP  [DI] , 7  
         JE   _70
         CMP  [DI] , 8  
         JE   _80  
         CMP  [DI] , 9            ;[DI] BELLEK GOZUNDEKI DEGERI O ILE KIYASLANDI
         JE   _90                 ;9 ISE _90 ETIKETINE DALLANDI
     
         _00:                     ;_00 ETIKETI
          JMP ATLA                ;ATLA' YA DALLANDI
         _10:                     ;_10 ETIKETI 
         STRING_YAZ on            ;EKRANA ON YAZDIRILDI
         JMP ATLA                 ;ATLA' YA DALLANDI
         _20:
         STRING_YAZ yirmi   
         JMP ATLA 
         _30:
         STRING_YAZ otuz   
         JMP ATLA 
         _40:
         STRING_YAZ kirk   
         JMP ATLA 
         _50:
         STRING_YAZ elli    
         JMP ATLA 
         _60:
         STRING_YAZ altmis  
         JMP ATLA 
         _70:
         STRING_YAZ yetmis    
         JMP ATLA 
         _80:
         STRING_YAZ seksen     
         JMP ATLA 
         _90:                     ;_90 ETIKETI 
         STRING_YAZ doksan        ;EKRANA DOKSAN YAZDIRILDI
         JMP ATLA                 ;ATLA' YA DALLANDI   
         
     BIRBASAMAK:                  ;BIR BASAMAKLI SAYI ISE DALLANAN ETIKET
         CMP  [DI] , 0           ;[DI] BELLEK GOZUNDEKI DEGERI O ILE KIYASLANDI
         JE ATLA:                 ;0 ISE ATLA' YA DALLANDI                                                                            
         CMP  [DI] , 1 
         JE   _1
         CMP  [DI] , 2  
         JE   _2
         CMP  [DI] , 3  
         JE   _3
         CMP  [DI] , 4  
         JE   _4
         CMP  [DI] , 5  
         JE   _5
         CMP  [DI] , 6  
         JE   _6
         CMP  [DI] , 7  
         JE   _7
         CMP  [DI] , 8  
         JE   _8  
         CMP  [DI] , 9            ;[DI] BELLEK GOZUNDEKI DEGERI 9 ILE KIYASLANDI
         JE   _9                  ;9 ISE _9 ETIKETINE DALLANDI
         
         _1:                      ;_1 ETIKETI
         STRING_YAZ bir           ;EKRANA BIR YAZDIRILDI
         JMP ATLA                 ;ATLA' YA DALLANDI
         _2:
         STRING_YAZ iki        
         JMP ATLA 
         _3:
         STRING_YAZ uc    
         JMP ATLA 
         _4:
         STRING_YAZ dort      
         JMP ATLA 
         _5:
         STRING_YAZ bes      
         JMP ATLA 
         _6:
         STRING_YAZ alti    
         JMP ATLA 
         _7:
         STRING_YAZ yedi   
         JMP ATLA 
         _8:
         STRING_YAZ sekiz  
         JMP ATLA 
         _9:                      ;_9 ETIKETI
         STRING_YAZ dokuz         ;EKRANA DOKUZ YAZDIRILDI
       
       ATLA:                      ;ATLA ETIKETI
       INC  DI                    ;DI DEGERI 1 ARTIRILDI (BIR SONRAKI BELLEK GOZUNE ULASMAK ICIN)
       DEC  CX                    ;CX DEGERI 1 ARTIRILDI
       
       CMP CX , 0                 ;CX DEGERI 0 ILE KIYASLANDI
       JA  DONGU                  ;0 DAN BUYUK OLDUKÇA DONGU ETIKETINE DALLANIR
       POP CX                     ;STACK'TEN CX'E YUKLENDI
ENDM                              ;MAKRO SONLANDIRILDI
                                                                             

;**************  YAZI BASAMAKLARI SAYIYA CEVIREN MAKRO   **********************;  
                   
                   ;CEVIR_SAYI MAKROSU;

;BU MAKRO KULLANICIDAN ALINAN SAYI BASAMAKLARI YAZIYA CEVIRMEYE YARAMAKTADIR.
;KULLANICIDAN KARAKTER OKUNURKEN BOSLUGA BASILANA KADAR KARAKTERLERI SIRALI
;SEKILDE "userString" KATAR DEGISKENINDE TUTULUR VE BOSLUK A BASILDIGINDA 
;BIR BASAMAK ALINDI DEMEK VE O YAZI BASAMAGIN ILK ADRESI BU MAKROYA VERILIR
;VE SAYILARLA KIYASLAYARAK SAYIYI BULUNUR BULDUGU SAYI 0 ILE 99 ARASINDA ISE
;BP SAKLAYICISINDAKI DEGERI ILE TOPLAR VE SONUC BP YE KAYDEDILIR
;YOKSA EGER YUZ ISE BIR ONCE GELEN DEGERE BAKAR. EGER O SIFIR ISE BIR YAPAR
;100 ILE ÇARPAR VE BP ILE TOPLAR
;EGER SIFIR DEGILSE BIR ONCE DEGER BP DEN CIKARTIR VE YUZ ILE CARPAR VE TEKRAR 
;BP DEGERIYLE TOPLAYIP YINE BP YE KAYDEDER
;BOYLECE SON DEGER BP DE OLUYOR

;******************************************************************************;

 CEVIR_SAYI MACRO   str           ;MAKRO TAMIMLANDI
                                  ;LOCAL BASLIKLI SATIRLAR , MAKRO ICINDE KULLANILAN ETIKETLERI LOKAL OLARAK TANIMLANDI  
                                  ;"DUPLICATE LABEL HATASINI ONLER"
    
     LOCAL SONN , HATA ,BIR_ATA,DEVAM_ET ,BIR_YAP ,ISLEME_GEC , BIR1 , IKI2 , UC3 , DORT4 
     LOCAL BES5 , ALTI6 , YEDI7 ,SEKIZ8 , DOKUZ9 , ON10 ,YIRMI20, OTUZ30, KIRK40 , ELLI50
     LOCAL ALTMIS60 , YETMIS70 , SEKSEN80 , DOKSAN90 , YUZ100 , BIN1000  
      
      mov cx , basamakSayaci      ;CX' E SAYIYA CEVIRELECEK YAZININ HARF SAYISI YUKLENDI
      lea si , str                ;SI' E str KATARININ EFEKTIF ADRESI YUKLENDI    (KAYNAK OLARAK AYARLANDI)
      lea di , sifir              ;DI' E sifir KATARININ EFEKTIF ADRESI YUKLENDI  (HEDEF  OLARAK AYARLANDI)
      cld                         ;KATAR ISLEME YONU AYARLANDI (OTOMATIK ARTIRIMI)
      repe cmpsb                  ;KAYNAK VE HEDEF KATARLARI KIYASLANDI
      jne  BIR1                   ;GIRILEN KATAR SIFIR' DAN FARKLI ISE BIR1 ETIKETINE DALLANDI
                                  ;SIFIRA ESIT DURUMU
      mov bx , 0                  ;BX' E 0 DEGERI YUKLENDI 
      mov tempBx , 0
      jmp SONN                    ;SONN  ETIKETINE DALLANDI
              
    BIR1:                         ;BIR1 ETIKETI
      mov cx , basamakSayaci      ;CX' E SAYIYA CEVIRELECEK YAZININ HARF SAYISI YUKLENDI
      lea si , str                ;SI' E str KATARININ EFEKTIF ADRESI YUKLENDI    (KAYNAK OLARAK AYARLANDI)
      lea di , bir                ;DI' E bir KATARININ EFEKTIF ADRESI YUKLENDI  (HEDEF  OLARAK AYARLANDI)
      cld                         ;KATAR ISLEME YONU AYARLANDI (OTOMATIK ARTIRIMI)
      repe cmpsb                  ;KAYNAK VE HEDEF KATARLARI KIYASLANDI
      jne  IKI2                   ;GIRILEN KATAR BIR' DEN FARKLI ISE IKI2' E DALLANDI
                                  ;BIR'E ESIT DURUMU
      mov  bx , 1                 ;BX' E 1 DEGERI YUKLENDI 
      mov tempBx , 1
      add  bp , bx                ;BP <-- BP + BX
      jmp SONN                    ;SONN ETIKETINE DALLANDI
                       
    IKI2:                         ;IKI2 ETIKETI
      mov cx , basamakSayaci      ;CX' E SAYIYA CEVIRELECEK YAZININ HARF SAYISI YUKLENDI
      lea si , str                ;SI' E str KATARININ EFEKTIF ADRESI YUKLENDI    (KAYNAK OLARAK AYARLANDI)
      lea di , iki                ;DI' E iki KATARININ EFEKTIF ADRESI YUKLENDI  (HEDEF  OLARAK AYARLANDI)
      cld                         ;KATAR ISLEME YONU AYARLANDI (OTOMATIK ARTIRIMI)
      repe cmpsb                  ;KAYNAK VE HEDEF KATARLARI KIYASLANDI
      jne  UC3                    ;GIRILEN KATAR 2' DEN FARKLI ISE UC3' E DALLANDI
                                  ;IKI' YE ESIT DURUMU
      mov  bx , 2                 ;BX' E 2 DEGERI YUKLENDI  
      mov tempBx , 2
      add  bp , bx                ;BP <-- BP + BX
      jmp SONN                    ;SONN ETIKETINE DALLANDI
    
    UC3:                          ;UC3 ETIKETI
      mov cx , basamakSayaci      ;CX' E SAYIYA CEVIRELECEK YAZININ HARF SAYISI YUKLENDI
      lea si , str                ;SI' E str KATARININ EFEKTIF ADRESI YUKLENDI    (KAYNAK OLARAK AYARLANDI)
      lea di , uc                 ;DI' E uc KATARININ EFEKTIF ADRESI YUKLENDI  (HEDEF  OLARAK AYARLANDI)
      cld                         ;KATAR ISLEME YONU AYARLANDI (OTOMATIK ARTIRIMI)
      repe cmpsb                  ;KAYNAK VE HEDEF KATARLARI KIYASLANDI
      jne  DORT4                  ;GIRILEN KATAR 3' DEN FARKLI ISE DORT4' E DALLANDI
                                  ;UC' E ESIT DURUMU
      mov  bx , 3                 ;BX' E 3 DEGERI YUKLENDI 
      mov tempBx , 3
      add  bp , bx                ;BP <-- BP + BX
      jmp SONN                    ;SONN ETIKETINE DALLANDI
            
    DORT4:                        ;DORT4 ETIKETI
      mov cx , basamakSayaci      ;CX' E SAYIYA CEVIRELECEK YAZININ HARF SAYISI YUKLENDI
      lea si , str                ;SI' E str KATARININ EFEKTIF ADRESI YUKLENDI    (KAYNAK OLARAK AYARLANDI)
      lea di , dort               ;DI' E dort KATARININ EFEKTIF ADRESI YUKLENDI  (HEDEF  OLARAK AYARLANDI)
      cld                         ;KATAR ISLEME YONU AYARLANDI (OTOMATIK ARTIRIMI)
      repe cmpsb                  ;KAYNAK VE HEDEF KATARLARI KIYASLANDI
      jne  BES5                   ;GIRILEN KATAR 4' DEN FARKLI ISE BES5' E DALLANDI
                                  ;4' E ESIT DURUMU
      mov  bx , 4                 ;BX' E 4 DEGERI YUKLENDI  
      mov tempBx , 4
      add  bp , bx                ;BP <-- BP + BX
      jmp SONN                    ;SONN ETIKETINE DALLANDI
           
    BES5:                         ;BES5 ETIKETI
      mov cx , basamakSayaci      ;CX' E SAYIYA CEVIRELECEK YAZININ HARF SAYISI YUKLENDI
      lea si , str                ;SI' E str KATARININ EFEKTIF ADRESI YUKLENDI    (KAYNAK OLARAK AYARLANDI)
      lea di , bes                ;DI' E bes KATARININ EFEKTIF ADRESI YUKLENDI  (HEDEF  OLARAK AYARLANDI)
      cld                         ;KATAR ISLEME YONU AYARLANDI (OTOMATIK ARTIRIMI)
      repe cmpsb                  ;KAYNAK VE HEDEF KATARLARI KIYASLANDI
      jne  ALTI6                  ;GIRILEN KATAR 5' DEN FARKLI ISE ALTI' YA DALLANDI
                                  ;5' E ESIT DURUMU
      mov  bx , 5                 ;BX' E 5 DEGERI YUKLENDI   
      mov tempBx , 5
      add  bp , bx                ;BP <-- BP + BX
      jmp SONN                    ;SONN ETIKETINE DALLANDI
    
    ALTI6:                        ;ALTI6 ETIKETI
      mov cx , basamakSayaci      ;CX' E SAYIYA CEVIRELECEK YAZININ HARF SAYISI YUKLENDI
      lea si , str                ;SI' E str KATARININ EFEKTIF ADRESI YUKLENDI    (KAYNAK OLARAK AYARLANDI)
      lea di , alti               ;DI' E alti KATARININ EFEKTIF ADRESI YUKLENDI  (HEDEF  OLARAK AYARLANDI)
      cld                         ;KATAR ISLEME YONU AYARLANDI (OTOMATIK ARTIRIMI)
      repe cmpsb                  ;KAYNAK VE HEDEF KATARLARI KIYASLANDI
      jne  YEDI7                  ;GIRILEN KATAR 6' DAN FARKLI ISE YEDI7' YE DALLANDI
                                  ;6' YA ESIT DURUMU
      mov  bx , 6                 ;BX' E 6 DEGERI YUKLENDI  
      mov tempBx , 6
      add  bp , bx                ;BP <-- BP + BX
      jmp SONN                    ;SONN ETIKETINE DALLANDI
      
   YEDI7:                         ;YEDI7 ETIKETI
      mov cx , basamakSayaci      ;CX' E SAYIYA CEVIRELECEK YAZININ HARF SAYISI YUKLENDI
      lea si , str                ;SI' E str KATARININ EFEKTIF ADRESI YUKLENDI    (KAYNAK OLARAK AYARLANDI)
      lea di , yedi               ;DI' E yedi KATARININ EFEKTIF ADRESI YUKLENDI  (HEDEF  OLARAK AYARLANDI)
      cld                         ;KATAR ISLEME YONU AYARLANDI (OTOMATIK ARTIRIMI)
      repe cmpsb                  ;KAYNAK VE HEDEF KATARLARI KIYASLANDI
      jne  SEKIZ8                 ;GIRILEN KATAR 7' DAN FARKLI ISE SEKIZ8' E DALLANDI
                                  ;7' YE ESIT DURUMU
      mov  bx , 7                 ;BX' E 7 DEGERI YUKLENDI  
      mov tempBx , 7
      add  bp , bx                ;BP <-- BP + BX
      jmp SONN                    ;SONN ETIKETINE DALLANDI
           
   SEKIZ8:                        ;SEKIZ8 ETIKETI
      mov cx , basamakSayaci      ;CX' E SAYIYA CEVIRELECEK YAZININ HARF SAYISI YUKLENDI
      lea si , str                ;SI' E str KATARININ EFEKTIF ADRESI YUKLENDI    (KAYNAK OLARAK AYARLANDI)
      lea di , sekiz              ;DI' E sekiz KATARININ EFEKTIF ADRESI YUKLENDI  (HEDEF  OLARAK AYARLANDI)
      cld                         ;KATAR ISLEME YONU AYARLANDI (OTOMATIK ARTIRIMI)
      repe cmpsb                  ;KAYNAK VE HEDEF KATARLARI KIYASLANDI
      jne  DOKUZ9                 ;GIRILEN KATAR 8' DAN FARKLI ISE DOKUZ9' A DALLANDI
                                  ;8' YE ESIT DURUMU
      mov  bx , 8                 ;BX' E 8 DEGERI YUKLENDI 
      mov tempBx ,8
      add  bp , bx                ;BP <-- BP + BX
      jmp SONN                    ;SONN ETIKETINE DALLANDI
      
   DOKUZ9:                        ;DOKUZ9 ETIKETI
      mov cx , basamakSayaci      ;CX' E SAYIYA CEVIRELECEK YAZININ HARF SAYISI YUKLENDI
      lea si , str                ;SI' E str KATARININ EFEKTIF ADRESI YUKLENDI    (KAYNAK OLARAK AYARLANDI)
      lea di , dokuz              ;DI' E dokuz KATARININ EFEKTIF ADRESI YUKLENDI  (HEDEF  OLARAK AYARLANDI)
      cld                         ;KATAR ISLEME YONU AYARLANDI (OTOMATIK ARTIRIMI)
      repe cmpsb                  ;KAYNAK VE HEDEF KATARLARI KIYASLANDI
      jne      ON10               ;GIRILEN KATAR 9' DAN FARKLI ISE ON10' A DALLANDI
                                  ;9' YE ESIT DURUMU
      mov  bx , 9                 ;BX' E 9 DEGERI YUKLENDI 
      mov tempBx , 9
      add  bp , bx                ;BP <-- BP + BX
      jmp SONN                    ;SONN ETIKETINE DALLANDI
      
       
    ON10:                         ;ON10 ETIKETI
      mov cx , basamakSayaci      ;CX' E SAYIYA CEVIRELECEK YAZININ HARF SAYISI YUKLENDI
      lea si , str                ;SI' E str KATARININ EFEKTIF ADRESI YUKLENDI    (KAYNAK OLARAK AYARLANDI)
      lea di , on                 ;DI' E on KATARININ EFEKTIF ADRESI YUKLENDI  (HEDEF  OLARAK AYARLANDI)
      cld                         ;KATAR ISLEME YONU AYARLANDI (OTOMATIK ARTIRIMI)
      repe cmpsb                  ;KAYNAK VE HEDEF KATARLARI KIYASLANDI
      jne      YIRMI20            ;GIRILEN KATAR 10' DAN FARKLI ISE YIRMI20' YE DALLANDI
                                  ;10' YE ESIT DURUMU
      mov  bx , 10                ;BX' E 10 DEGERI YUKLENDI
      add  bp , bx                ;BP <-- BP + BX
      jmp SONN                    ;SONN ETIKETINE DALLANDI
 
   YIRMI20:                       ;YIRMI20 ETIKETI
      mov cx , basamakSayaci      ;CX' E SAYIYA CEVIRELECEK YAZININ HARF SAYISI YUKLENDI
      lea si , str                ;SI' E str KATARININ EFEKTIF ADRESI YUKLENDI    (KAYNAK OLARAK AYARLANDI)
      lea di , yirmi              ;DI' E yirmi KATARININ EFEKTIF ADRESI YUKLENDI  (HEDEF  OLARAK AYARLANDI)
      cld                         ;KATAR ISLEME YONU AYARLANDI (OTOMATIK ARTIRIMI)
      repe cmpsb                  ;KAYNAK VE HEDEF KATARLARI KIYASLANDI
      jne      OTUZ30             ;GIRILEN KATAR 20' DAN FARKLI ISE OTUZ30' A DALLANDI
                                  ;20' YE ESIT DURUMU
      mov  bx , 20                ;BX' E 20 DEGERI YUKLENDI
      add  bp , bx                ;BP <-- BP + BX
      jmp SONN                    ;SONN ETIKETINE DALLANDI
      
      
    OTUZ30:                       ;OTUZ30 ETIKETI
      mov cx , basamakSayaci      ;CX' E SAYIYA CEVIRELECEK YAZININ HARF SAYISI YUKLENDI
      lea si , str                ;SI' E str KATARININ EFEKTIF ADRESI YUKLENDI    (KAYNAK OLARAK AYARLANDI)
      lea di , otuz               ;DI' E otuz KATARININ EFEKTIF ADRESI YUKLENDI  (HEDEF  OLARAK AYARLANDI)
      cld                         ;KATAR ISLEME YONU AYARLANDI (OTOMATIK ARTIRIMI)
      repe cmpsb                  ;KAYNAK VE HEDEF KATARLARI KIYASLANDI
      jne      KIRK40             ;GIRILEN KATAR 30' DAN FARKLI ISE KIRK40' A DALLANDI 
                                  ;30' YE ESIT DURUMU 
      mov  bx , 30                ;BX' E 30 DEGERI YUKLENDI 
      add  bp , bx                ;BP <-- BP + BX
      jmp SONN                    ;SONN ETIKETINE DALLANDI
       
    KIRK40:                       ;KIRK40 ETIKETI
      mov cx , basamakSayaci      ;CX' E SAYIYA CEVIRELECEK YAZININ HARF SAYISI YUKLENDI
      lea si , str                ;SI' E str KATARININ EFEKTIF ADRESI YUKLENDI    (KAYNAK OLARAK AYARLANDI)
      lea di , kirk               ;DI' E kirk KATARININ EFEKTIF ADRESI YUKLENDI  (HEDEF  OLARAK AYARLANDI)
      cld                         ;KATAR ISLEME YONU AYARLANDI (OTOMATIK ARTIRIMI)  
      repe cmpsb                  ;KAYNAK VE HEDEF KATARLARI KIYASLANDI  
      jne      ELLI50             ;GIRILEN KATAR 40' TAN FARKLI ISE ELLI50' YE DALLANDI
                                  ;40' YE ESIT DURUMU
      mov  bx , 40                ;BX' E 40 DEGERI YUKLENDI
      add  bp , bx                ;BP <-- BP + BX    
      jmp SONN                    ;SONN ETIKETINE DALLANDI 
      
    ELLI50:                       ;ELLI50 ETIKETI
      mov cx , basamakSayaci      ;CX' E SAYIYA CEVIRELECEK YAZININ HARF SAYISI YUKLENDI
      lea si , str                ;SI' E str KATARININ EFEKTIF ADRESI YUKLENDI    (KAYNAK OLARAK AYARLANDI)
      lea di , elli               ;DI' E elli KATARININ EFEKTIF ADRESI YUKLENDI  (HEDEF  OLARAK AYARLANDI)
      cld                         ;KATAR ISLEME YONU AYARLANDI (OTOMATIK ARTIRIMI) 
      repe cmpsb                  ;KAYNAK VE HEDEF KATARLARI KIYASLANDI   
      jne      ALTMIS60           ;GIRILEN KATAR 50' DAN FARKLI ISE ALTMIS60' A DALLANDI
                                  ;50' YE ESIT DURUMU
      mov  bx , 50                ;BX' E 50 DEGERI YUKLENDI
      add  bp , bx                ;BP <-- BP + BX
      jmp SONN                    ;SONN ETIKETINE DALLANDI
      
    ALTMIS60:                     ;ALTMIS60 ETIKETI
      mov cx , basamakSayaci      ;CX' E SAYIYA CEVIRELECEK YAZININ HARF SAYISI YUKLENDI
      lea si , str                ;SI' E str KATARININ EFEKTIF ADRESI YUKLENDI    (KAYNAK OLARAK AYARLANDI)
      lea di , altmis             ;DI' E altmis KATARININ EFEKTIF ADRESI YUKLENDI  (HEDEF  OLARAK AYARLANDI) 
      cld                         ;KATAR ISLEME YONU AYARLANDI (OTOMATIK ARTIRIMI) 
      repe cmpsb                  ;KAYNAK VE HEDEF KATARLARI KIYASLANDI        
      jne      YETMIS70           ;GIRILEN KATAR 60' DAN FARKLI ISE YETMIS70' A DALLANDI 
                                  ;60' YE ESIT DURUMU
      mov  bx , 60                ;BX' E 60 DEGERI YUKLENDI
      add  bp , bx                ;BP <-- BP + BX    
      jmp SONN                    ;SONN ETIKETINE DALLANDI  
   
    YETMIS70:                     ;YETMIS70 ETIKETI
      mov cx , basamakSayaci      ;CX' E SAYIYA CEVIRELECEK YAZININ HARF SAYISI YUKLENDI
      lea si , str                ;SI' E str KATARININ EFEKTIF ADRESI YUKLENDI    (KAYNAK OLARAK AYARLANDI)
      lea di , yetmis             ;DI' E yetmis KATARININ EFEKTIF ADRESI YUKLENDI  (HEDEF  OLARAK AYARLANDI)
      cld                         ;KATAR ISLEME YONU AYARLANDI (OTOMATIK ARTIRIMI)
      repe cmpsb                  ;KAYNAK VE HEDEF KATARLARI KIYASLANDI          
      jne      SEKSEN80           ;GIRILEN KATAR 70' DAN FARKLI ISE SEKSEN80' E DALLANDI
                                  ;70' YE ESIT DURUMU 
      mov  bx , 70                ;BX' E 70 DEGERI YUKLENDI
      add  bp , bx                ;BP <-- BP + BX 
      jmp SONN                    ;SONN ETIKETINE DALLANDI 
      
   SEKSEN80:                      ;SEKSEN80 ETIKETI
      mov cx , basamakSayaci      ;CX' E SAYIYA CEVIRELECEK YAZININ HARF SAYISI YUKLENDI    
      lea si , str                ;SI' E str KATARININ EFEKTIF ADRESI YUKLENDI    (KAYNAK OLARAK AYARLANDI) 
      lea di , seksen             ;DI' E seksen KATARININ EFEKTIF ADRESI YUKLENDI  (HEDEF  OLARAK AYARLANDI)
      cld                         ;KATAR ISLEME YONU AYARLANDI (OTOMATIK ARTIRIMI)   
      repe cmpsb                  ;KAYNAK VE HEDEF KATARLARI KIYASLANDI  
      jne      DOKSAN90           ;GIRILEN KATAR 80' DAN FARKLI ISE DOKSAN90' A DALLANDI
                                  ;80' YE ESIT DURUMU 
      mov  bx , 80                ;BX' E 80 DEGERI YUKLENDI
      add  bp , bx                ;BP <-- BP + BX    
      jmp SONN                    ;SONN ETIKETINE DALLANDI
       
    DOKSAN90:                     ;DOKSAN90 ETIKETI
      mov cx , basamakSayaci      ;CX' E SAYIYA CEVIRELECEK YAZININ HARF SAYISI YUKLENDI  
      lea si , str                ;SI' E str KATARININ EFEKTIF ADRESI YUKLENDI    (KAYNAK OLARAK AYARLANDI)  
      lea di , doksan             ;DI' E doksan KATARININ EFEKTIF ADRESI YUKLENDI  (HEDEF  OLARAK AYARLANDI)
      cld                         ;KATAR ISLEME YONU AYARLANDI (OTOMATIK ARTIRIMI)  
      repe cmpsb                  ;KAYNAK VE HEDEF KATARLARI KIYASLANDI  
      jne      YUZ100             ;GIRILEN KATAR 90' DAN FARKLI ISE YUZ100' A DALLANDI
                                  ;90' A ESIT DURUMU 
      mov  bx , 90                ;BX' E 90 DEGERI YUKLENDI 
      add  bp , bx                ;BP <-- BP + BX
      jmp SONN                    ;SONN ETIKETINE DALLANDI
     
     YUZ100:                      ;DOKSAN90 ETIKETI
      mov cx , basamakSayaci      ;CX' E SAYIYA CEVIRELECEK YAZININ HARF SAYISI YUKLENDI
      lea si , str                ;SI' E str KATARININ EFEKTIF ADRESI YUKLENDI    (KAYNAK OLARAK AYARLANDI) 
      lea di , yuz                ;DI' E yuz KATARININ EFEKTIF ADRESI YUKLENDI  (HEDEF  OLARAK AYARLANDI)
      cld                         ;KATAR ISLEME YONU AYARLANDI (OTOMATIK ARTIRIMI)  
      repe cmpsb                  ;KAYNAK VE HEDEF KATARLARI KIYASLANDI 
      jne      BIN1000            ;GIRILEN KATAR 100' DAN FARKLI ISE YUZ100' A DALLANDI
      
                                  ;100' YE ESIT DURUMU 
      mov BX , tempBx                            
      CMP BX , 0                  ;BX , 0 ILE KIYASLANDI
      JE  BIR_YAP                 ;0 ISE BIR_YAP ETIKETINE DALLANDI
      SUB BP , BX                 ;0'DAN FARKLI ISE  BP <-- BP - BX
      JMP ISLEME_GEC              ;ISLEME_GEC ETIKETINE DALLANDI
                
      BIR_YAP:                    ;BIR_YAP ETIKETI
      MOV BX , 1                  ;BX' E 1 DEGERI YUKLENDI
       
      ISLEME_GEC:                 ;ISLEME_GEC ETIKETI
      mov ax , 100                ;AX' E 100  DEGERI YUKLENDI
      mul bx                      ;AX <-- AX * BX
      add bp , ax                 ;BP <-- BP + AX 
      jmp SONN                    ;SONN ETIKETINE DALLANDI
      
      BIN1000:                    ;BIN1000 ETIKETI
      mov cx , basamakSayaci      ;CX' E SAYIYA CEVIRELECEK YAZININ HARF SAYISI YUKLENDI
      lea si , str                ;SI' E str KATARININ EFEKTIF ADRESI YUKLENDI    (KAYNAK OLARAK AYARLANDI) 
      lea di , bin                ;DI' E bin KATARININ EFEKTIF ADRESI YUKLENDI  (HEDEF  OLARAK AYARLANDI)
      cld                         ;KATAR ISLEME YONU AYARLANDI (OTOMATIK ARTIRIMI)
      repe cmpsb                  ;KAYNAK VE HEDEF KATARLARI KIYASLANDI 
      jne    HATA                 ;GIRILEN KATAR 100' DAN FARKLI ISE HATA' YA DALLANDI
                                  ;1000' E ESIT DURUMU 
      cmp bp , 0                  ;BP , 0 ILE KIYASLANDI
      je BIR_ATA                  ;BIR_ATA ETIKETINE DALLANDI
      jmp DEVAM_ET                ;DEVAM_ET ETIKETINE DALLANDI
      BIR_ATA:                    ;BIR_ATA ETIKETI
      mov bp , 01h                ;BP' E 1 DEGERI YUKLENDI
      
      DEVAM_ET:                   ;DEVAM_ET ETIKETI
      mov ax , 1000               ;AX' E 1000  DEGERI YUKLENDI
      mul bp                      ;AX <-- AX * BP
      mov bp , ax                 ;BP <-- AX
      jmp SONN                    ;SONN ETIKETINE DALLANDI
 
      HATA:                       ;HATA ETIKETI
         ret                      ;PROGRAM' DAN DÖNDÜ
      SONN:                       ;SON ETIKETI
      ENDM                        ;MAKRO SONLANDIRILDI  
    
;************************ RES KATAR  DEGERI INITIALIZE EDILIR ***************; 
                         ;RESINIT MAKROSU;

;RES KATARI TEKRARDAN KULLANMAK UZERE HER DEFASINDA SIFIRLIYORUZ
;****************************************************************************; 
      RESINIT MACRO 
        push cx  
        mov  cx , 10
        lea  si , RES1
        lea  di , RES
        rep movsb 
        pop cx
        ENDM 

;*** KULLANICIDAN ALINAN HER YAZI BASAMAGI SAYIYA CEVIREN MAKRO **************; 
      ;  KULLANICI_YAZI_AL  MAKROSU ;
      
;BU MAKRO KULLANICIDAN YAZI ALARAK CEVIR_SAYI MAKROSUNU KULLANARAK  
;YAZI BASAMAKLARI SAYIYA CEVIRMEKTEDIR
;BOSLUK GORDUGUNDE BASAMAK ALIR VE CEVIR_SAYIR MAKROSUNA ATAR VE CEVIRILIR
;DEVAM EDER KULLANICI ENTER TUSUNA BASANA KADAR DEVAM EDER
;*****************************************************************************; 

;  
  
KULLANICI_YAZI_AL MACRO           ;MAKRO TAMIMLANDI
                                  ;LOCAL BASLIKLI SATIRLAR , MAKRO ICINDE KULLANILAN ETIKETLERI LOKAL OLARAK TANIMLANDI  
                                  ;"DUPLICATE LABEL HATASINI ONLER"
                                       
     LOCAL basla , BAS , cevirBitir , cevirSadece
     basla:                       ;basla1 ETIKETINE DALLANDI
     lea si , userString          ;SI' E userString KATARININ EFEKTIF ADRESI YUKLENDI
     mov basamakSayaci , 00h      ;basamakSayaci SIFIRLANDI
     BAS:                         ;BAS1 ETIKETINE DALLANDI
     mov ah , 01h                 ;AH' E 1 DEGERIN YUKLENDI (BIR KARAKTER OKUYAN FONKSIYONU)
     int 21h                      ;FONKSIYONUN BULUNDUGU KESME SECILDI
     
     cmp al , 0dh                 ;ALINAN KARAKTER 0DH ILE KIYASLANDI(ENTER TUSUNA BASILIP BASILMADIGI KONTROL EDILDI)
     je cevirBitir                ;cevirBitir ETIKETINE DALLANDI
     cmp al , 32                  ;AL' DEGERI 32 ILE KIYASLANDI (BOSLUK TUSUNA BASILIP BASILMADIGI KONTROL EDILDI)
     je cevirSadece               ;OYLE ISE cevirSadece ETIKETINE DALLANDI
     
     mov [si] , al                ;[SI] BELLEK GOZUNE AL DEGERI ATANDI
     inc basamakSayaci            ;basamakSayaci 1 ARTIRILDI
     inc si                       ;SI DEGERI 1 ARTIRILDI
     jmp BAS                      ;BAS ETIKETINE DALLANDI
     
     cevirSadece:                 ;cevirSadece ETIKETI
     CEVIR_SAYI userString        ;CEVIR_SAYI MAKROSU ÇAGRILDI
     lea si , userString          ;SI' E userString KATARININ EFEKTIF ADRESI YUKLENDI
     jmp basla                    ;basla ETIKETINE DALLANDI

     cevirBitir:                  ;cevirBitir ETIKETINE DALLANDI
     CEVIR_SAYI userString        ;CEVIR_SAYI MAKROSU ÇAGRILDI
     lea si , userString          ;SI' E userString KATARININ EFEKTIF ADRESI YUKLENDI
     mov basamakSayaci , 00h      ;basamakSayaci SIFIRLANDI
ENDM                              ;MAKRO SONLANDIRILDI
    
 
 ;********************************  ENGLISH *******************************************;    
     
 TRANSLATE MACRO address               ;MAKRO TAMIMLANDI
                                  ;LOCAL BASLIKLI SATIRLAR , MAKRO ICINDE KULLANILAN ETIKETLERI LOKAL OLARAK TANIMLANDI  
                                  ;"DUPLICATE LABEL HATASINI ONLER" 
    
    LOCAL DONGU , ATLA , UCBASAMAK , IKIBASAMAK , BIRBASAMAK 
    LOCAL _000, _100 , _200 , _300 , _400 , _500 , _600 , _700 , _800 , _900 
    LOCAL _00 , _10 , _20 , _30 , _40 , _50 , _60 , _70 , _80 , _90
    LOCAL _1 , _2 , _3 , _4 , _5 , _6 , _7 , _8 , _9
    
         mov  di , address        ;PARAMETRE OLARAK ALINAN ADRES DI' YE YUKLENDI
         push cx                  ;CX' IN DEGERI STACK' E ATILDI
         mov  cx , bx             ;BX' ADRESI CX' E YUKLENDI
    DONGU:                        ;DONGU  ETIKETI        
         CMP CX , 3               ;CX' IN ICINDEKI DEGERI 3 ILE KIYASLANDI
         JE  UCBASAMAK            ;3 ISE UCBASAMAK ETIKETINE DALLAN
         CMP CX , 2               ;CX' IN ICINDEKI DEGERI 2 ILE KIYASLANDI
         JE  IKIBASAMAK           ;2 ISE UCBASAMAK ETIKETINE DALLAN
         CMP CX , 1               ;CX' IN ICINDEKI DEGERI 1 ILE KIYASLANDI
         JE  BIRBASAMAK           ;1 ISE UCBASAMAK ETIKETINE DALLANDI
         
     UCBASAMAK:                   ;UC BASAMAKLI SAYI ISE DALLANAN ETIKET
         CMP  [DI] , 0            ;[DI] BELLEK GOZUNDEKI DEGERI O ILE KIYASLANDI 
         JE  _000                 ;0 ISE _000 ETIKETINE DALLANDI         
         CMP  [DI] , 1            ;[DI] BELLEK GOZUNDEKI DEGERI 1 ILE KIYASLANDI
         JE   _100                ;1 ISE _100 ETIKETINE DALLANDI
         CMP  [DI] , 2            
         JE   _200                
         CMP  [DI] , 3            
         JE   _300                
         CMP  [DI] , 4         
         JE   _400               
         CMP  [DI] , 5           
         JE   _500                
         CMP  [DI] , 6          
         JE   _600                
         CMP  [DI] , 7            
         JE   _700                
         CMP  [DI] , 8            
         JE   _800                
         CMP  [DI] , 9            ;[DI] BELLEK GOZUNDEKI DEGERI 9 ILE KIYASLANDI
         JE   _900                ;9 ISE _900 ETIKETINE DALLANDI
     
         _000:                    ;_000 ETIKETI
         JMP ATLA                 ;ATLA ETIKETINE DALLANDI
         _100:                    ;_100 ETIEKTI
         STRING_YAZ hundred           ;EKRANA YUZ YAZDIRILDI 
         JMP ATLA                 ;ATLA' YA DALLANDI     
         _200:                    ;_200 ETIKETI
         STRING_YAZ two           ;EKRANA IKI YAZDIRILDI
         STRING_YAZ hundred           ;EKRANA YUZ YAZDIRILDI
         JMP ATLA                 ;ATLAYA DALLANDI
         _300:                    
         STRING_YAZ three            
         STRING_YAZ hundred           
         JMP ATLA                 
         _400:
         STRING_YAZ four
         STRING_YAZ hundred         
         JMP ATLA 
         _500:
         STRING_YAZ five
         STRING_YAZ hundred   
         JMP ATLA 
         _600:
         STRING_YAZ six
         STRING_YAZ hundred   
         JMP ATLA 
         _700:
         STRING_YAZ seven
         STRING_YAZ hundred 
         JMP ATLA 
         _800:
         STRING_YAZ eight
         STRING_YAZ hundred   
         JMP ATLA 
         _900:                    ;_900 ETIKETI
         STRING_YAZ nine         ;EKRANA DOKUZ YAZDIRILDI
         STRING_YAZ hundred           ;EKRANA YUZ YAZDIRILDI
         JMP ATLA                 ;ATLAYA DALLANDI
                 
     IKIBASAMAK:                  ;IKI BASAMAKLI SAYI ISE DALLANAN ETIKET
         CMP  [DI] , 0            ;[DI] BELLEK GOZUNDEKI DEGERI O ILE KIYASLANDI
         JE  _00                  ;0 ISE _00 ETIKETINE DALLANDI
         CMP  [DI] , 1 
         JE   _10
         CMP  [DI] , 2  
         JE   _20
         CMP  [DI] , 3  
         JE   _30
         CMP  [DI] , 4  
         JE   _40
         CMP  [DI] , 5  
         JE   _50
         CMP  [DI] , 6  
         JE   _60
         CMP  [DI] , 7  
         JE   _70
         CMP  [DI] , 8  
         JE   _80  
         CMP  [DI] , 9            ;[DI] BELLEK GOZUNDEKI DEGERI O ILE KIYASLANDI
         JE   _90                 ;9 ISE _90 ETIKETINE DALLANDI
     
         _00:                     ;_00 ETIKETI
          JMP ATLA                ;ATLA' YA DALLANDI
         _10:                     ;_10 ETIKETI 
         STRING_YAZ ten            ;EKRANA ON YAZDIRILDI
         JMP ATLA                 ;ATLA' YA DALLANDI
         _20:
         STRING_YAZ twenty   
         JMP ATLA 
         _30:
         STRING_YAZ thirty   
         JMP ATLA 
         _40:
         STRING_YAZ fourty   
         JMP ATLA 
         _50:
         STRING_YAZ fifty    
         JMP ATLA 
         _60:
         STRING_YAZ sixty  
         JMP ATLA 
         _70:
         STRING_YAZ seventy    
         JMP ATLA 
         _80:
         STRING_YAZ eighty     
         JMP ATLA 
         _90:                     ;_90 ETIKETI 
         STRING_YAZ ninety        ;EKRANA DOKSAN YAZDIRILDI
         JMP ATLA                 ;ATLA' YA DALLANDI   
         
     BIRBASAMAK:                  ;BIR BASAMAKLI SAYI ISE DALLANAN ETIKET
         CMP  [DI] , 0           ;[DI] BELLEK GOZUNDEKI DEGERI O ILE KIYASLANDI
         JE ATLA:                 ;0 ISE ATLA' YA DALLANDI                                                                            
         CMP  [DI] , 1 
         JE   _1
         CMP  [DI] , 2  
         JE   _2
         CMP  [DI] , 3  
         JE   _3
         CMP  [DI] , 4  
         JE   _4
         CMP  [DI] , 5  
         JE   _5
         CMP  [DI] , 6  
         JE   _6
         CMP  [DI] , 7  
         JE   _7
         CMP  [DI] , 8  
         JE   _8  
         CMP  [DI] , 9            ;[DI] BELLEK GOZUNDEKI DEGERI 9 ILE KIYASLANDI
         JE   _9                  ;9 ISE _9 ETIKETINE DALLANDI
         
         _1:                      ;_1 ETIKETI
         STRING_YAZ one           ;EKRANA BIR YAZDIRILDI
         JMP ATLA                 ;ATLA' YA DALLANDI
         _2:
         STRING_YAZ two        
         JMP ATLA 
         _3:
         STRING_YAZ three    
         JMP ATLA 
         _4:
         STRING_YAZ four      
         JMP ATLA 
         _5:
         STRING_YAZ five      
         JMP ATLA 
         _6:
         STRING_YAZ six    
         JMP ATLA 
         _7:
         STRING_YAZ seven   
         JMP ATLA 
         _8:
         STRING_YAZ eight  
         JMP ATLA 
         _9:                      ;_9 ETIKETI
         STRING_YAZ nine         ;EKRANA DOKUZ YAZDIRILDI
       
       ATLA:                      ;ATLA ETIKETI
       INC  DI                    ;DI DEGERI 1 ARTIRILDI (BIR SONRAKI BELLEK GOZUNE ULASMAK ICIN)
       DEC  CX                    ;CX DEGERI 1 ARTIRILDI
       
       CMP CX , 0                 ;CX DEGERI 0 ILE KIYASLANDI
       JA  DONGU                  ;0 DAN BUYUK OLDUKÇA DONGU ETIKETINE DALLANIR
       POP CX                     ;STACK'TEN CX'E YUKLENDI
ENDM                              ;MAKRO SONLANDIRILDI
   
     
     
;***************************************************************************************************************;    
     
     
     
     
      
      
TRANSLATE_NUMBER MACRO   str           ;MAKRO TAMIMLANDI
                                  ;LOCAL BASLIKLI SATIRLAR , MAKRO ICINDE KULLANILAN ETIKETLERI LOKAL OLARAK TANIMLANDI  
                                  ;"DUPLICATE LABEL HATASINI ONLER"
    
     LOCAL SONN , HATA ,BIR_ATA,DEVAM_ET ,BIR_YAP ,ISLEME_GEC , BIR1 , IKI2 , UC3 , DORT4 
     LOCAL BES5 , ALTI6 , YEDI7 ,SEKIZ8 , DOKUZ9 , ON10 ,YIRMI20, OTUZ30, KIRK40 , ELLI50
     LOCAL ALTMIS60 , YETMIS70 , SEKSEN80 , DOKSAN90 , YUZ100 , BIN1000  
      
      mov cx , stepCounter      
      lea si , str                
      lea di , zero              
      cld                        
      repe cmpsb                 
      jne  BIR1                   
                                 
      mov bx , 0                   
      mov tempBxx , 0
      jmp SONN                    
              
    BIR1:                         
      mov cx , stepCounter    
      lea si , str                
      lea di , one                
      cld                        
      repe cmpsb                 
      jne  IKI2                 
                                 
      mov  bx , 1                 
      mov tempBxx , 1
      add  bp , bx                
      jmp SONN                   
                       
    IKI2:                        
      mov cx , stepCounter      
      lea si , str                
      lea di , two                
      cld                         
      repe cmpsb                 
      jne  UC3                    
                                
      mov  bx , 2                 
      mov tempBxx , 2
      add  bp , bx                
      jmp SONN                    
    
    UC3:                         
      mov cx , stepCounter      
      lea si , str                
      lea di , three                
      cld                        
      repe cmpsb                  
      jne  DORT4                 
                                 
      mov  bx , 3                
      mov tempBxx , 3
      add  bp , bx               
      jmp SONN                   
            
    DORT4:                       
      mov cx , stepCounter      
      lea si , str                
      lea di , four               
      cld                         
      repe cmpsb                 
      jne  BES5                   
                                  
      mov  bx , 4                
      mov tempBxx , 4
      add  bp , bx                
      jmp SONN                    
           
    BES5:                         
      mov cx , stepCounter      
      lea si , str               
      lea di , five                
      cld                        
      repe cmpsb                 
      jne  ALTI6                 
                                  
      mov  bx , 5                 
      mov tempBxx , 5
      add  bp , bx               
      jmp SONN                   
    
    ALTI6:                        
      mov cx , stepCounter      
      lea si , str               
      lea di , six               
      cld                         
      repe cmpsb                 
      jne  YEDI7                  
                                 
      mov  bx , 6                
      mov tempBxx , 6
      add  bp , bx               
      jmp SONN                    
      
   YEDI7:                        
      mov cx , stepCounter      
      lea si , str                
      lea di , seven               
      cld                        
      repe cmpsb                  
      jne  SEKIZ8                 
                                 
      mov  bx , 7                 
      mov tempBxx , 7
      add  bp , bx                
      jmp SONN                    
           
   SEKIZ8:                       
      mov cx , stepCounter      
      lea si , str               
      lea di , eight             
      cld                         
      repe cmpsb                 
      jne  DOKUZ9                
                                 
      mov  bx , 8                 
      mov tempBxx ,8
      add  bp , bx                
      jmp SONN                   
      
   DOKUZ9:                        
      mov cx , stepCounter     
      lea si , str                
      lea di , nine              
      cld                         
      repe cmpsb                  
      jne      ON10               
                                 
      mov  bx , 9                 
      mov tempBxx , 9
      add  bp , bx               
      jmp SONN                  
      
       
    ON10:                         
      mov cx , stepCounter      
      lea si , str                
      lea di , ten                
      cld                        
      repe cmpsb                  
      jne      YIRMI20           
                                 
      mov  bx , 10                
      add  bp , bx               
      jmp SONN                   
 
   YIRMI20:                       
      mov cx , stepCounter    
      lea si , str                
      lea di , twenty              
      cld                        
      repe cmpsb                 
      jne      OTUZ30           
                                
      mov  bx , 20              
      add  bp , bx             
      jmp SONN                    
      
      
    OTUZ30:                      
      mov cx , stepCounter      
      lea si , str               
      lea di , thirty               
      cld                         
      repe cmpsb                 
      jne      KIRK40            
                                 
      mov  bx , 30                
      add  bp , bx             
      jmp SONN                    
       
    KIRK40:                       
      mov cx , stepCounter      
      lea si , str               
      lea di , fourty               
      cld                          
      repe cmpsb                  
      jne      ELLI50             
                                 
      mov  bx , 40                
      add  bp , bx                   
      jmp SONN                    
      
    ELLI50:                       
      mov cx , stepCounter     
      lea si , str                
      lea di , fifty              
      cld                        
      repe cmpsb                  
      jne      ALTMIS60          
                                  
      mov  bx , 50              
      add  bp , bx                
      jmp SONN                    
      
    ALTMIS60:                     
      mov cx , stepCounter    
      lea si , str               
      lea di , sixty             
      cld                       
      repe cmpsb                  
      jne      YETMIS70           
                                
      mov  bx , 60                
      add  bp , bx               
      jmp SONN                  
   
    YETMIS70:                   
      mov cx , stepCounter      
      lea si , str               
      lea di , seventy            
      cld                       
      repe cmpsb                      
      jne      SEKSEN80          
                                 
      mov  bx , 70                
      add  bp , bx                
      jmp SONN                   
      
   SEKSEN80:                     
      mov cx , stepCounter     
      lea si , str                
      lea di , eighty            
      cld                           
      repe cmpsb                  
      jne      DOKSAN90           
                                  
      mov  bx , 80               
      add  bp , bx                   
      jmp SONN                    
       
    DOKSAN90:                    
      mov cx , stepCounter      
      lea si , str                 
      lea di , ninety             
      cld                         
      repe cmpsb                  
      jne      YUZ100            
                                   
      mov  bx , 90                
      add  bp , bx                
      jmp SONN                   
     
     YUZ100:                      
      mov cx , stepCounter     
      lea si , str                 
      lea di , hundred             
      cld                      
      repe cmpsb                 
      jne      BIN1000            
      
                                  
      mov BX , tempBxx                            
      CMP BX , 0                
      JE  BIR_YAP                
      SUB BP , BX                
      JMP ISLEME_GEC             
                
      BIR_YAP:                    
      MOV BX , 1               
       
      ISLEME_GEC:                 
      mov ax , 100               
      mul bx                    
      add bp , ax                 
      jmp SONN                    
      
      BIN1000:                    
      mov cx , stepCounter      
      lea si , str                
      lea di , thousand             
      cld                         
      repe cmpsb                 
      jne    HATA                
                                  
      cmp bp , 0                 
      je BIR_ATA                 
      jmp DEVAM_ET               
      BIR_ATA:                   
      mov bp , 01h                
      
      DEVAM_ET:                   
      mov ax , 1000               
      mul bp                   
      mov bp , ax                
      jmp SONN                  
 
      HATA:                       
         ret                      
      SONN:                    
 ENDM                         
     
     
     
 ;*************************************************************************************************************   
 
TEXT_FROM_USER MACRO          
                                   
                                
                                       
     LOCAL basla , BAS , cevirBitir , cevirSadece
     basla:                       
     lea si , userStringEn        
     mov stepCounter , 00h      
     BAS:                         
     mov ah , 01h                
     int 21h                      
     
     cmp al , 0dh                
     je cevirBitir                
     cmp al , 32                  
     je cevirSadece               
     
     mov [si] , al               
     inc stepCounter            
     inc si                      
     jmp BAS                      
     
     cevirSadece:                 
     TRANSLATE_NUMBER userStringEn       
     lea si , userStringEn          
     jmp basla                    

     cevirBitir:                 
     TRANSLATE_NUMBER userStringEn       
     lea si , userStringEn         
     mov stepCounter , 00h      
ENDM                              
  
     
   
;***************************  PROGRAMIN ANA GOVDESI  *************************;

org 100h

  .DATA                           ;VERI SEGMENTI
                                  ;BU SEGMENTTE PROGRAM BOYUNDA KULLANILACAK VERILER TANIMLANDI
     
     ;GENEL VERILER                                  
     dilSecimi       db  'Lutfen dili seciniz / Please select language: $'
     turkcee         db  '1 - Turkce  $'
     englishh        db  '2 - English $'   
     
     sayiYazi        db  '1 - Sayi --> Yazi: $'
     yaziSayi        db  '2 - Yazi --> Sayi: $'
     islem           db  '3 - Yazi ile islem: $'
     
     sayiGirdi       db  'Lutfen yaziya cevrilecek sayiyi giriniz.(Max trilyona kadar , trilyon dahil) $'
     cevap           db  'Cevap: $'    
     yaziGirdi       db  'Lutfen sayiya cevrilecek yazi karsiligini giriniz.(Max trilyona kadar, trilyon dahil) $'   
     
     toplama         db  '1 - Toplama: $'
     cikarma         db  '2 - Cikarma: $'    
     
     operand1Girdi   db  'Lutfen operand1 giriniz. (Max milyona kadar, milyon dahil) $'
     operand2Girdi   db  'Lutfen operand1 giriniz. (Max milyona kadar, milyon dahil) $' 
            
     new_line        db  0DH , 0AH , '$' ;YENI SATIR ICIN
      
     
     sifir   db  "sifir $"        ;KATARLAR DEGISKENLERI TANIMLANDI
     bir     db  "bir $" 
     iki     db  "iki $"
     uc      db  "uc $"
     dort    db  "dort $"
     bes     db  "bes $"
     alti    db  "alti $"
     yedi    db  "yedi $"
     sekiz   db  "sekiz $"
     dokuz   db  "dokuz $" 
     
     on      db  "on $"
     yirmi   db  "yirmi $"
     otuz    db  "otuz $"
     kirk    db  "kirk $"
     elli    db  "elli $"  
     altmis  db  "altmis $"
     yetmis  db  "yetmis $"
     seksen  db  "seksen $"
     doksan  db  "doksan $"
     
     yuz     db  "yuz $"
     bin     db  "bin $" 
     milyon  db  "milyon $"
     milyar  db  "milyar $"       
     trilyon db  "trilyon $"  
     
     ;SORU1
     counter         dw  00h      
     temp            db  00h 
     address         dw  00h 
     
     ;SORU2      
      basamakSayaci  dw 00h 
      userString     db 100 dup('$')        
      RES  DB 10 DUP ('$')
      RES1 DB 10 DUP ('$') 
      
      tempBx dw 00h
      ;SORU3 TOPLAMA
      b1 dw 00h
      b2 dw 00h
      esit db " = $"
      arti db " + $"
      eksi db " - $" 
      
      ;INGLIZCE      
      numberWord        db  '1 - Number --> Word: $'
      wordNumber        db  '2 - Word --> Number: $'
      operation           db  '3 - Operation with word: $'
     
      numberEnter       db  'Please enter number to be translate into word.(Max Trillion , trillion include) $'
      answer            db  'Answer: $'    
      wordEnter         db  'Please enter word to be translate into number.(Max Trillion , trillion include) $'   
     
      addition         db  '1 - Addition: $'
      subtraction      db  '2 - Subtraction: $'    
     
      operand1Enter   db  'Please enter operand1. (Max million , million include) $'
      operand2Enter   db  'Please enter operand2. (Max million , million include) $'  
      
       zero    db  "zero $"        ;KATARLAR DEGISKENLERI TANIMLANDI
       one     db  "one $" 
       two     db  "two $"
       three   db  "three $"
       four    db  "four $"
       five    db  "five $"
       six     db  "six $"
       seven   db  "seven $"
       eight   db  "eight $"
       nine    db  "nine $"  
       
       eleven    db  "eleven $"
       twelve    db  "twelve $"
       thirteen  db  "thirteen $"
       fourteen  db  "fourteen $"
       fifteen   db  "fifteen $"
       sixteen   db  "sixteen $"
       seventeen db  "seventeen $"
       eighteen  db  "eighteen $"
       nineteen  db  "nineteen $"
                           
                           
       ten      db  "ten $"
       twenty   db  "twenty $"
       thirty   db  "thirty $"
       fourty   db  "fourty $"
       fifty    db  "fifty $"  
       sixty    db  "sixty $"
       seventy  db  "seventy $"
       eighty   db  "eighty $"
       ninety   db  "ninety $"
     
       hundred  db  "hundred $"
       thousand db  "thousand $" 
       million  db  "million $"
       billion  db  "billion $"       
       trillion db  "trillion $"  
       
     ;SORU1
     counterEn       dw  00h      
     tempEn          db  00h 
     
     ;SORU2      
      stepCounter   dw 00h 
      userStringEn  db 100 dup('$')  
      tempBxx dw 00h
      ;SORU3
      c1 dw 00h
      c2 dw 00h
            
      
      
           
  .CODE                           ;KOD SEGMENTI
     MOV AX , @DATA               ;AX <-- @DATA
     MOV DS , AX                  ;DS <-- @DATA
     MOV ES , AX                  ;ES <-- @DATA
ANAMENUYE_GEC: 
 
     MOV AX,0600H    ;06 TO SCROLL & 00 FOR FULLJ SCREEN
     MOV BH,0AH      ;ATTRIBUTE 0 FOR BACKGROUND AND 7 FOR FOREGROUND
     MOV CX,00H      ;STARTING COORDINATES
     MOV DX,184FH    ;ENDING COORDINATES
     INT 10H         ;FOR VIDEO DISPLAY 
     
       
     STRING_YAZ dilSecimi         ;dilSecimi KATARINI EKRANA YAZDIRILDI
     CALL YENI_SATIR              ;CALL KOMUTUYLA YENI_SATIR ALTPROGRAMINI CAGRILDI
     STRING_YAZ turkcee           ;turkcee KATARINI EKRANA YAZDIRILDI
     call YENI_SATIR              
     STRING_YAZ englishh          ;englishh KATARINI EKRANA YAZDIRILDI
     CALL YENI_SATIR
      

       
      
      
YENIDEN_SEC:
      ETIKET:     
      MOV AH , 01H                
      INT 21H
      CMP AL , 0DH
      JE ENTER
      MOV [SI],AL 
      JMP ETIKET    
      ENTER:
      CMP [SI] , '1'
      JE   TURKCE                  ;1 ISE TURKCE ETIKETINE DALLANDI
      CMP [DI] , '2'
      JE   ENGLISH                 ;2 ISE ENGLISH ETIKETINE DALLANDI 
JMP YENIDEN_SEC      
     
                        
TURKCE:
                           ;TURKCE ETIKETI
     CALL YENI_SATIR              ;CALL KOMUTUYLE YENI_SATIR ALTPROGRAMI CAGRILDI
     CALL YENI_SATIR              ;CALL KOMUTUYLE YENI_SATIR ALTPROGRAMI CAGRILDI
     STRING_YAZ sayiYazi          ;EKRANA sayiYazi KATARINI YAZDIRILDI
     CALL YENI_SATIR              ;CALL KOMUTUYLE YENI_SATIR ALTPROGRAMI CAGRILDI
     STRING_YAZ yaziSayi          ;EKRANA yaziSayi KATARINI YAZDIRILDI
     call YENI_SATIR              ;CALL KOMUTUYLE YENI_SATIR ALTPROGRAMI CAGRILDI
     STRING_YAZ islem             ;EKRANA islem KATARINI YAZDIRILDI
     CALL YENI_SATIR              ;CALL KOMUTUYLE YENI_SATIR ALTPROGRAMI CAGRILDI
     
       
     MOV  ah , 01h                ;KULLANICIDAN KARAKTER ALMA FONKSIYONU SECILDI
     INT  21h                     ;KARAKTER ALMA FONKSIYONUNUN BULUNDUGU KESME SECILDI
     CMP  al , '1'                ;ALINAN KARAKTER (AL ICERISIINDE) '1' ILE KIYASLANDI
     JE   SAYI_YAZIYA             ;1 ISE SAYI_YAZI ETIKETINE DALLANDI
     CMP  al , '2'                ;ALINAN KARAKTER (AL ICERISIINDE) '1' ILE KIYASLANDI
     JE   YAZI_SAYIYA             ;2 ISE YAZI_SAYI ETIKETINE DALLANDI
     CMP  al , '3'                ;ALINAN KARAKTER (AL ICERISIINDE) '1' ILE KIYASLANDI
     JE   ARITMETIC_ISLEM         ;3 ISE ARITHMETIC_ISLEM ETIKETINE DALLANDI

SAYI_YAZIYA:                      ;SAYI_YAZI ETIKETI     
     CALL YENI_SATIR              ;CALL KOMUTUYLE YENI_SATIR ALTPROGRAMI CAGRILDI
     CALL YENI_SATIR              ;CALL KOMUTUYLE YENI_SATIR ALTPROGRAMI CAGRILDI
     STRING_YAZ sayiGirdi         ;EKRANA sayiGirdi KATARINI YAZDIRILDI
     CALL YENI_SATIR              
     MOV  BP , 4000H              ;BP' YE 4000H DEGERI YUKLENDI
  GIR:                            ;GIR ETIKETI
     MOV  ah , 01h                ;KULLANICIDAN BIR KARAKTER AL
     INT  21h                     
     CMP  al , 0dh                ;ALINAN KARAKTER CARRIAGE RETURN KARAKTERI MI?
     JE   YAZIYACEVIR             ;CARRIAGE RERURN KARAKTERI ISE YAZIYACEVIR ETIKETINE DALLAN
     sub  al  , 48                ;DEGILSE ALINAN KARAKTERDEN 48 ÇIKART (ALFANUMERIK DEGERI SAYIYA DONUSTUR)
     MOV [BP] , al                ;VE CEVRILMIS DEGERI [BP] GOSTERDIGI BELLEK GOZUNE AT
     INC counter                  ;COUNTER DEGISKENI 1 ARTIR
     INC  BP                      ;BP' I 1 ARTIR
     JMP GIR                      ;GIR ETIKETINE DALLANDI
        
   YAZIYACEVIR:                   ;YAZIYACEVIR ETIKETI
     CALL YENI_SATIR              
     STRING_YAZ cevap             ;EKRANA CEVAP KATARINI YAZDIRILDI
     MOV  CX , counter            ;counter DEGERI CX' E YUKLENDI
     MOV  BP , 4000h              ;BP' YE 4000H DEGERI YUKLENDI
   YAZI:                          ;YAZI ETIKETI
     CMP cx , 15                  ;CX DEGERI 15 ILE KIYASLANDI
     JE  TRILYON_100              ;15 ISE TRILYON_100 ETIKETINE DALLANDI
     CMP cx , 14                  ;CX DEGERI 14ILE KIYASLANDI
     JE  TRILYON_10               ;14 ISE TRILYON_10 ETIKETINE DALLANDI
     CMP cx , 13                  ;CX DEGERI 13 ILE KIYASLANDI
     JE TRILYON_1                 ;13 ISE TRILYON_1 ETIKETINE DALLANDI

  MILYARA_GEC:                    ;MILYARA_GEC ETIKETI 
     CMP cx , 12                  ;CX DEGERI 12 ILE KIYASLANDI
     JE  MILYAR_100               ;12 ISE MILYAR_100 ETIKETINE DALLANDI
     CMP cx , 11                  ;CX DEGERI 11 ILE KIYASLANDI
     JE  MILYAR_10                ;11 ISE MILYAR_10 ETIKETINE DALLANDI
     CMP cx , 10                  ;CX DEGERI 11 ILE KIYASLANDI
     JE MILYAR_1                  ;11 ISE MILYAR_10 ETIKETINE DALLANDI
     
  MILYONA_GEC:                    ;MILYONA_GEC ETIKETI
     CMP cx ,  9                  ;CX DEGERI 9 ILE KIYASLANDI
     JE  MILYON_100               ;9 ISE MILYON_100 ETIKETINE DALLANDI
     CMP cx ,  8                  ;CX DEGERI 8 ILE KIYASLANDI
     JE  MILYON_10                ;8 ISE MILYON_10 ETIKETINE DALLANDI
     CMP cx , 7                   ;CX DEGERI 7 ILE KIYASLANDI
     JE MILYON_1                  ;7 ISE MILYON_1 ETIKETINE DALLANDI
     
  BINE_GEC:                       ;BINE_GEC ETIKETI
     CMP cx , 6                   ;CX DEGERI 6 ILE KIYASLANDI
     JE  BIN_100                  ;6 ISE BIN_100 ETIKETINE DALLANDI
     CMP cx , 5                   ;CX DEGERI 5 ILE KIYASLANDI
     JE  BIN_10                   ;5 ISE BIN_10 ETIKETINE DALLANDI
     CMP cx , 4                   ;CX DEGERI 4 ILE KIYASLANDI
     JE BIN_1                     ;4 ISE BIN_1 ETIKETINE DALLANDI
          
  YUZE_GEC:                       ;YUZE_GEC ETIKETI
     CMP cx , 3                   ;CX DEGERI 3 ILE KIYASLANDI
     JE  YUZ_100                  ;3 ISE YUZ_100 ETIKETINE DALLANDI
     CMP cx , 2                   ;CX DEGERI 2 ILE KIYASLANDI
     JE  YUZ_10                   ;2 ISE YUZ_10 ETIKETINE DALLANDI
     CMP cx , 1                   ;CX DEGERI 1 ILE KIYASLANDI
     JE  YUZ_1                    ;1 ISE YUZ_1 ETIKETINE DALLANDI
       
   TRILYON_100:                   ;TRILYON_100 ETIKETI
     mov bx , 3                   ;BX'E  3 DEGERI YUKLENDI 
     JMP TRILYON_AL               ;TRILYON_AL ETIKETINE DALLANDI
   TRILYON_10:                    ;TRILYON_10 ETIKETI
     mov bx , 2                   ;BX' 2 DEGERI YUKLENDI 
     JMP TRILYON_AL               ;TRILYON_AL ETIKETINE DALLANDI
   TRILYON_1:                     ;TRILYON_1 ETIKETI
     mov bx , 1                   ;BX' 1 DEGERI YUKLENDI
         
   TRILYON_AL:                    ;TRILYON_AL
     mov address ,  BP            ;address DEGISKENINE BP DEGERI ATANDI
     CEVIR  address               ;CEVIR MAKROSU CAGRILDI
     STRING_YAZ trilyon           ;EKRANA trilyon KATARI YAZDIRILDI
     sub cx , bx                  ;CX , BX DEGERI KADAR AZALDI
     add bp , bx                  ;BP , BX DEGERI KADAR ARTIRILDI
     JMP MILYARA_GEC              ;MILYARA_GEC ETIKETINE DALLANDI
     
    MILYAR_100:                   ;MILYAR_100 ETIKETI
     mov bx , 3                   ;BX'E  3 DEGERI YUKLENDI
     JMP MILYAR_AL                ;MILYAR_AL ETIKETINE DALLANDI
    MILYAR_10:                    ;MILYAR_10 ETIKETI
     mov bx , 2                   ;BX'E  2 DEGERI YUKLENDI
     JMP MILYAR_AL                ;MILYAR_AL ETIKETINE DALLANDI
    MILYAR_1:                     ;MILYAR_1 ETIKETI
     mov bx , 1                   ;BX'E  1 DEGERI YUKLENDI
     
    MILYAR_AL:                    ;MILYAR_AL
     mov address ,  BP            ;address DEGISKENINE BP DEGERI ATANDI
     CEVIR address                ;CEVIR MAKROSU CAGRILDI
     STRING_YAZ milyar            ;EKRANA milyar KATARI YAZDIRILDI
     sub cx , bx                  ;CX , BX DEGERI KADAR AZALDI
     add bp , bx                  ;BP , BX DEGERI KADAR ARTIRILDI
     JMP MILYONA_GEC              ;MILYONA_GEC ETIKETINE DALLANDI
     
     MILYON_100:                  ;MILYON_100 ETIKETI
     mov bx , 3                   ;BX'E  3 DEGERI YUKLENDI
     JMP MILYON_AL                ;MILYON_AL ETIKETINE DALLANDI
     MILYON_10:                   ;MILYON_10 ETIKETI
     mov bx , 2                   ;BX'E  2 DEGERI YUKLENDI
     JMP MILYON_AL                ;MILYON_AL ETIKETINE DALLANDI
     MILYON_1:                    ;MILYON_1 ETIKETI
     mov bx , 1                   ;BX'E  1 DEGERI YUKLENDI
     
     MILYON_AL:                   ;MILYON_AL
     mov address ,  BP            ;address DEGISKENINE BP DEGERI ATANDI
     CEVIR address                ;CEVIR MAKROSU CAGRILDI
     STRING_YAZ milyon            ;EKRANA milyon KATARI YAZDIRILDI
     sub cx , bx                  ;CX , BX DEGERI KADAR AZALDI
     add bp , bx                  ;BP , BX DEGERI KADAR ARTIRILDI
     JMP BINE_GEC                 ;BINE_GEC ETIKETINE DALLANDI
     
     BIN_100:                     ;BIN_100 ETIKETI
     mov bx , 3                   ;BX'E 3 DEGERI YUKLENDI
     JMP BIN_AL                   ;BIN_AL ETIKETINE DALLANDI
     BIN_10:                      ;BIN_10 ETIKETI
     mov bx , 2                   ;BX'E 2 DEGERI YUKLENDI
     JMP BIN_AL                   ;BIN_AL ETIKETINE DALLANDI
     BIN_1:                       ;BIN_1 ETIKETI
     mov bx , 1                   ;BX'E  1 DEGERI YUKLENDI
     
     BIN_AL:                      ;BIN_AL
     mov address ,  BP            ;address DEGISKENINE BP DEGERI ATANDI
     CEVIR address                ;CEVIR MAKROSU CAGRILDI
     STRING_YAZ bin               ;EKRANA bin KATARI YAZDIRILDI
     sub cx , bx                  ;CX , BX DEGERI KADAR AZALDI
     add bp , bx                  ;BP , BX DEGERI KADAR ARTIRILDI
     JMP YUZE_GEC                 ;YUZE_GEC ETIKETINE DALLANDI
     
     YUZ_100:                     ;YUZ_100 ETIKETI
     mov bx , 3                   ;BX'E 3 DEGERI YUKLENDI
     JMP YUZ_AL                   ;YUZ_AL ETIKETINE DALLANDI
     YUZ_10:                      ;YUZ_10 ETIKETI
     mov bx , 2                   ;BX'E 2 DEGERI YUKLENDI
     JMP YUZ_AL                   ;YUZ_AL ETIKETINE DALLANDI
     YUZ_1:                       ;YUZ_1 ETIKETI
     mov bx , 1                   ;BX'E 1 DEGERI YUKLENDI
     
     YUZ_AL:                      ;YUZ_AL
     mov address ,  BP            ;address DEGISKENINE BP DEGERI ATANDI
     CEVIR address                ;CEVIR MAKROSU CAGRILDI
     sub cx , bx                  ;CX , BX DEGERI KADAR AZALDI
     add bp , bx                  ;BP , BX DEGERI KADAR ARTIRILDI    
    
    
     
     MOV AH , 01H                 ;AH <-- 01H KARAKTER AL FONKSIYONU SECILDI
     INT 21H                      ;FONKSIYONUN BULUNDUGU KESME SECILDI
     CMP AL , 0DH                 ;AL DEGERI 0DH ILE KIYASLANDI (ENTER TUSUNA BASILIP BASILMADIGI KONTROL EDILDI)
     MOV counter , 00H            ;counter SIFIRLANDI
     
     JE ANAMENUYE_GEC             ;ANAMENUYE_GEC ETIKETINE DADLLANDI
     
     JMP SON                      ;PROGRAMI SONLANDIR
        
        
        
    
YAZI_SAYIYA:                      ;YAZI_SAYIYA ETIKETI
     CALL YENI_SATIR              ;CALL KOMUTUYLA YENI_SATIR ALTPROGRAMINI CAGRILDI (YENI SATIRA GECILDI)
     CALL YENI_SATIR              ;YENI SATIRA GECILDI
     STRING_YAZ yaziGirdi         ;EKRANA yaziGirdi KATARI YAZDIRILDI
     CALL YENI_SATIR              ;YENI SATIRA GECILDI

     KULLANICI_YAZI_AL             ;KULLANICI_YAZI_AL MAKROSU ÇAGRILDI
     CALL YENI_SATIR               ;YENI SATIRA GECILDI
     STRING_YAZ cevap              ;EKRANA cevap KATARI YAZDIRILDI
         RESINIT                   ;RES KATARI INITIALIZE EDILDI ('$')
     MOV AX , BP                   ;AX <-- BP
     LEA SI,RES                    ;SI' E RES KATARININ EFEKTIF ADRESI YUKLENDI
     CALL HEX2DEC                  ;CALL KOMUTUYLE HEX2DEC FONKSIYONU ÇAGRILDI
     STRING_YAZ RES                ;EKRANA RES KATARI YAZDIRILDI
     
   
     
     
     JMP SON                       ;SON ETIKETINE DALLANDI    
ARITMETIC_ISLEM:                   ;ARITMETIC_ISLEM ETIKETI
                                   
     CALL YENI_SATIR               ;CALL KOMUTUYLA YENI_SATIR FONKSIYONU ÇAGRILDI (YENI SATIRA GECILDI)
     CALL YENI_SATIR               ;CALL KOMUTUYLA YENI_SATIR FONKSIYONU ÇAGRILDI (YENI SATIRA GECILDI)
     STRING_YAZ toplama            ;EKRANA toplama KATARI YADIRILDI     (TOPLAMA ISLEMI SECENEGI)
     CALL YENI_SATIR               ;CALL KOMUTUYLA YENI_SATIR FONKSIYONU ÇAGRILDI (YENI SATIRA GECILDI)
     STRING_YAZ cikarma            ;EKRANA cikarma KATARI YADIRILDI     (CIKARMA ISLEMI SECENEGI)
     CALL YENI_SATIR               ;CALL KOMUTUYLA YENI_SATIR FONKSIYONU ÇAGRILDI (YENI SATIRA GECILDI)
     MOV  ah , 01h                 ;AH <-- 01 (BIR KARAKTER AL FONKSIYONU SECILDI)
     INT  21h                      ;FONKSIYONUN BUKUNDUGU KESME SECILDI
     CMP  al , '1'                 ;ALINAN KARAKTER(AL DEGERI) '1' ILE KIYASLANDI
     JE   TOPLAMA_ISLEMI           ;'1' ISE TOPLAMA_ISLEMI ETIKETINE DALLANDI 
     CMP  al , '2'                 ;ALINAN KARAKTER(AL DEGERI) '2' ILE KIYASLANDI
     JE   CIKARMA_ISLEMI           ;'2' ISE CIKARMA_ISLEMI ETIKETINE DALLANDI
     

TOPLAMA_ISLEMI:                    ;TOPLAMA_ISLEMI ETIKETI
     CALL YENI_SATIR               ;CALL KOMUTUYLA YENI_SATIR FONKSIYONU ÇAGRILDI (YENI SATIRA GECILDI)
     CALL YENI_SATIR               ;CALL KOMUTUYLA YENI_SATIR FONKSIYONU ÇAGRILDI (YENI SATIRA GECILDI)
     STRING_YAZ operand1Girdi      ;EKRANA operand1Girdi KATARI YADIRILDI
     CALL YENI_SATIR               ;CALL KOMUTUYLA YENI_SATIR FONKSIYONU ÇAGRILDI (YENI SATIRA GECILDI)
     
     mov tempBx , 00h              ;tempBx SIFIRLANDI
     KULLANICI_YAZI_AL             ;KULLANICI_YAZI_AL MAKROSU CAGRILDI
     mov b1 , bp                   ;b1 <-- BP 
     mov bp , 00h                  ;BP <-- 00H     
     call YENI_SATIR               ;CALL KOMUTUYLA YENI_SATIR FONKSIYONU ÇAGRILDI (YENI SATIRA GECILDI)
     
     STRING_YAZ operand2Girdi      ;EKRANA operand2Girdi KATARI YADIRILDI
     call YENI_SATIR               ;CALL KOMUTUYLA YENI_SATIR FONKSIYONU ÇAGRILDI (YENI SATIRA GECILDI)
     mov tempBx , 00h
     KULLANICI_YAZI_AL             ;KULLANICI_YAZI_AL MAKROSU CAGRILDI
     mov b2 , bp                   ;b2 <-- BP
     add bp , b1                   ;BP <-- BP +  b1
     mov tempBx , 00h              ;,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,;
     call YENI_SATIR               ;CALL KOMUTUYLA YENI_SATIR FONKSIYONU ÇAGRILDI (YENI SATIRA GECILDI)
     STRING_YAZ cevap              ;EKRANA cevap KATARI YADIRILDI
 
     MOV AX , b1                   ;AX <-- b1 
     LEA SI,RES                    ;SI' E RES KATARININ EFEKTIF ADRESI YUKLENDI
     CALL HEX2DEC                  ;CALL KOMUTUYLA HEX2DEC ALTPROGRAMI CAGRILDI (OPERAND1 DEGERI ONLUGA CEVRILDI)
         STRING_YAZ RES            ;EKRANA RES KATARI YADIRILDI   (ILK OPERANDIN ONLUK DEGERI)
         STRING_YAZ arti           ;EKRANA arti KATARI YADIRILDI  
         RESINIT   
     MOV AX , b2                   ;AX <-- b2
     LEA SI,RES                    ;SI' E RES KATARININ EFEKTIF ADRESI YUKLENDI
     CALL HEX2DEC                  ;CALL KOMUTUYLA HEX2DEC ALTPROGRAMI CAGRILDI (OPERAND2 DEGERI ONLUGA CEVRILDI)
         STRING_YAZ RES            ;EKRANA RES KATARI YADIRILDI   (IKINCI OPERANDIN ONLUK DEGERI)
         STRING_YAZ esit           ;EKRANA arti KATARI YADIRILDI 
         RESINIT
     MOV AX , BP                   ;AX <-- BP  (HEX DEGERI DECIMALE CEVIRMEK UZERE BOLME ISLEMI ICIN)
     LEA SI,RES                    ;SI' E RES KATARININ EFEKTIF ADRESI YUKLENDI
     CALL HEX2DEC                  ;CALL KOMUTUYLA HEX2DEC ALTPROGRAMI CAGRILDI (ISLEM SONUCU DEGERI ONLUGA CEVRILDI)
         STRING_YAZ RES            ;EKRANA RES KATARI YADIRILDI   (TOPLAMA SONUCUNUN ONLUK DEGERI)

     JMP SON                       ;SON ETIKETINE DALLANDI (PROGRAM SONLANDIRILDI)

CIKARMA_ISLEMI:                    ;CIKARMA_ISLEMI
 
     CALL YENI_SATIR               ;CALL KOMUTUYLA YENI_SATIR FONKSIYONU ÇAGRILDI (YENI SATIRA GECILDI)
     CALL YENI_SATIR               ;CALL KOMUTUYLA YENI_SATIR FONKSIYONU ÇAGRILDI (YENI SATIRA GECILDI)
     STRING_YAZ operand1Girdi      ;EKRANA operand1Girdi KATARI YADIRILDI
     CALL YENI_SATIR               ;CALL KOMUTUYLA YENI_SATIR FONKSIYONU ÇAGRILDI (YENI SATIRA GECILDI)
     KULLANICI_YAZI_AL             ;KULLANICI_YAZI_AL MAKROSU CAGRILDI
     MOV b1 , BP                   ;b1 <-- BP
     MOV BP , 00h                  ;BP <-- 00H
     
     CALL YENI_SATIR               ;CALL KOMUTUYLA YENI_SATIR FONKSIYONU ÇAGRILDI (YENI SATIRA GECILDI)
     STRING_YAZ operand2Girdi      ;EKRANA operand2Girdi KATARI YADIRILDI
     CALL YENI_SATIR               ;CALL KOMUTUYLA YENI_SATIR FONKSIYONU ÇAGRILDI (YENI SATIRA GECILDI)
     mov tempBx , 00h              ;tempBx SIFIRLANDI
     KULLANICI_YAZI_AL             ;KULLANICI_YAZI_AL MAKROSU CAGRILDI  
     CALL YENI_SATIR               ;CALL KOMUTUYLA YENI_SATIR FONKSIYONU ÇAGRILDI (YENI SATIRA GECILDI)
     STRING_YAZ cevap              ;EKRANA cevap KATARI YAZDIRILDI
     MOV b2 , BP                   ;b2 <-- BP
     MOV AX , b1                   ;AX <-- b1   
        RESINIT
     LEA SI,RES                    ;KULLANICI_YAZI_AL MAKROSU CAGRILDI
     CALL HEX2DEC                  ;CALL KOMUTUYLA HEX2DEC ALTPROGRAMI CAGRILDI (OPERAND1 DEGERI ONLUGA CEVRILDI)
         STRING_YAZ RES            ;EKRANA RES KATARI YADIRILDI
         STRING_YAZ eksi           ;EKRANA eksi KATARI YADIRILDI
     MOV AX , b2                   ;AX <-- b2
         RESINIT
     LEA SI,RES                    ;SI' E RES KATARININ EFEKTIF ADRESI YUKLENDI
     CALL HEX2DEC                  ;CALL KOMUTUYLA HEX2DEC ALTPROGRAMI CAGRILDI (OPERAND2 DEGERI ONLUGA CEVRILDI)
         STRING_YAZ RES            ;EKRANA RES KATARI YADIRILDI
         STRING_YAZ esit           ;EKRANA RES KATARI YADIRILDI     
     CMP BP , b1                   ;b1 ILE BP KIYASLANDI
     JA  b2Buyuk                   ;b2Buyuk ETIKETINE DALLANDI (b2/BP BUYUK OLDUGU DURUM)
      SUB b1 , BP                  ;b1 <-- B1 - BP
      MOV BP , b1                  ;BP <-- b1
      JMP bpp                      ;bpp ETIKETINE DALLANDI
     b2Buyuk:                      ;b2Buyuk ETIKETI
      SUB BP , b1                  ;BP <-- BP - b1
         STRING_YAZ eksi           ;EKRANA eksi KATARI YADIRILDI 
      
     bpp:                          ;bpp ETIKETI  
         RESINIT
      MOV AX , BP                  ;AX <-- BP
      LEA SI,RES                   ;SI' E RES KATARININ EFEKTIF ADRESI YUKLENDI
      CALL HEX2DEC                 ;CALL KOMUTUYLA HEX2DEC ALTPROGRAMI CAGRILDI (CIKARMA SONUCUNUN DEGERI ONLUGA CEVRILDI)
         STRING_YAZ RES            ;EKRANA RES KATARI YADIRILDI
 
JMP SON                            ;SON ETIKETINE DALLANDI (PROGRAM SONLANDIRILDI) 




      
ENGLISH:    

    CALL YENI_SATIR              ;CALL KOMUTUYLE YENI_SATIR ALTPROGRAMI CAGRILDI
     CALL YENI_SATIR              ;CALL KOMUTUYLE YENI_SATIR ALTPROGRAMI CAGRILDI
     STRING_YAZ numberWord          ;EKRANA sayiYazi KATARINI YAZDIRILDI
     CALL YENI_SATIR              ;CALL KOMUTUYLE YENI_SATIR ALTPROGRAMI CAGRILDI
     STRING_YAZ wordNumber          ;EKRANA yaziSayi KATARINI YAZDIRILDI
     call YENI_SATIR              ;CALL KOMUTUYLE YENI_SATIR ALTPROGRAMI CAGRILDI
     STRING_YAZ operation             ;EKRANA islem KATARINI YAZDIRILDI
     CALL YENI_SATIR              ;CALL KOMUTUYLE YENI_SATIR ALTPROGRAMI CAGRILDI
     
       
     MOV  ah , 01h                ;KULLANICIDAN KARAKTER ALMA FONKSIYONU SECILDI
     INT  21h                     ;KARAKTER ALMA FONKSIYONUNUN BULUNDUGU KESME SECILDI
     CMP  al , '1'                ;ALINAN KARAKTER (AL ICERISIINDE) '1' ILE KIYASLANDI
     JE   NUMBER_WORD             ;1 ISE SAYI_YAZI ETIKETINE DALLANDI
     CMP  al , '2'                ;ALINAN KARAKTER (AL ICERISIINDE) '1' ILE KIYASLANDI
     JE   WORD_NUMBER             ;2 ISE YAZI_SAYI ETIKETINE DALLANDI
     CMP  al , '3'                ;ALINAN KARAKTER (AL ICERISIINDE) '1' ILE KIYASLANDI
     JE   ARITHMETIC_OPERATION        ;3 ISE ARITHMETIC_ISLEM ETIKETINE DALLANDI

NUMBER_WORD:                      ;SAYI_YAZI ETIKETI     
     CALL YENI_SATIR              ;CALL KOMUTUYLE YENI_SATIR ALTPROGRAMI CAGRILDI
     CALL YENI_SATIR              ;CALL KOMUTUYLE YENI_SATIR ALTPROGRAMI CAGRILDI
     STRING_YAZ numberEnter         ;EKRANA sayiGirdi KATARINI YAZDIRILDI
     CALL YENI_SATIR              
     MOV  BP , 4000H              ;BP' YE 4000H DEGERI YUKLENDI
  ENTER1:                            ;GIR ETIKETI
     MOV  ah , 01h                ;KULLANICIDAN BIR KARAKTER AL
     INT  21h                     
     CMP  al , 0dh                ;ALINAN KARAKTER CARRIAGE RETURN KARAKTERI MI?
     JE   TRANSLATETOWORD             ;CARRIAGE RERURN KARAKTERI ISE YAZIYACEVIR ETIKETINE DALLAN
     sub  al  , 48                ;DEGILSE ALINAN KARAKTERDEN 48 ÇIKART (ALFANUMERIK DEGERI SAYIYA DONUSTUR)
     MOV [BP] , al                ;VE CEVRILMIS DEGERI [BP] GOSTERDIGI BELLEK GOZUNE AT
     INC counterEn                  ;COUNTER DEGISKENI 1 ARTIR
     INC  BP                      ;BP' I 1 ARTIR
     JMP ENTER1                      ;GIR ETIKETINE DALLANDI
        
   TRANSLATETOWORD:                   ;YAZIYACEVIR ETIKETI
     CALL YENI_SATIR              
     STRING_YAZ answer             ;EKRANA CEVAP KATARINI YAZDIRILDI
     MOV  CX , counterEn            ;counter DEGERI CX' E YUKLENDI
     MOV  BP , 4000h              ;BP' YE 4000H DEGERI YUKLENDI
   WORD1:                          ;YAZI ETIKETI
     CMP cx , 15                  ;CX DEGERI 15 ILE KIYASLANDI
     JE  TRILLION_100              ;15 ISE TRILYON_100 ETIKETINE DALLANDI
     CMP cx , 14                  ;CX DEGERI 14ILE KIYASLANDI
     JE  TRILLION_10               ;14 ISE TRILYON_10 ETIKETINE DALLANDI
     CMP cx , 13                  ;CX DEGERI 13 ILE KIYASLANDI
     JE TRILLION_1                 ;13 ISE TRILYON_1 ETIKETINE DALLANDI

  GOBILLION:                    ;MILYARA_GEC ETIKETI 
     CMP cx , 12                  ;CX DEGERI 12 ILE KIYASLANDI
     JE  BILLION_100               ;12 ISE MILYAR_100 ETIKETINE DALLANDI
     CMP cx , 11                  ;CX DEGERI 11 ILE KIYASLANDI
     JE  BILLION_10             ;11 ISE MILYAR_10 ETIKETINE DALLANDI
     CMP cx , 10                  ;CX DEGERI 11 ILE KIYASLANDI
     JE BILLION_1                 ;11 ISE MILYAR_10 ETIKETINE DALLANDI
     
  GOMILLION:                    ;MILYONA_GEC ETIKETI
     CMP cx ,  9                  ;CX DEGERI 9 ILE KIYASLANDI
     JE  MILLION_100               ;9 ISE MILYON_100 ETIKETINE DALLANDI
     CMP cx ,  8                  ;CX DEGERI 8 ILE KIYASLANDI
     JE  MILLION_10                ;8 ISE MILYON_10 ETIKETINE DALLANDI
     CMP cx , 7                   ;CX DEGERI 7 ILE KIYASLANDI
     JE MILLION_1                  ;7 ISE MILYON_1 ETIKETINE DALLANDI
     
  GOTHOUSAND:                       ;BINE_GEC ETIKETI
     CMP cx , 6                   ;CX DEGERI 6 ILE KIYASLANDI
     JE  THOUSAND_100                  ;6 ISE BIN_100 ETIKETINE DALLANDI
     CMP cx , 5                   ;CX DEGERI 5 ILE KIYASLANDI
     JE  THOUSAND_10                   ;5 ISE BIN_10 ETIKETINE DALLANDI
     CMP cx , 4                   ;CX DEGERI 4 ILE KIYASLANDI
     JE THOUSAND_1                     ;4 ISE BIN_1 ETIKETINE DALLANDI
          
  GOHUNDRED:                       ;YUZE_GEC ETIKETI
     CMP cx , 3                   ;CX DEGERI 3 ILE KIYASLANDI
     JE  HUNDRED_100                  ;3 ISE YUZ_100 ETIKETINE DALLANDI
     CMP cx , 2                   ;CX DEGERI 2 ILE KIYASLANDI
     JE  HUNDRED_10                   ;2 ISE YUZ_10 ETIKETINE DALLANDI
     CMP cx , 1                   ;CX DEGERI 1 ILE KIYASLANDI
     JE  HUNDRED_1                    ;1 ISE YUZ_1 ETIKETINE DALLANDI
       
   TRILLION_100:                   ;TRILYON_100 ETIKETI
     mov bx , 3                   ;BX'E  3 DEGERI YUKLENDI 
     JMP TAKETRILLION               ;TRILYON_AL ETIKETINE DALLANDI
   TRILLION_10:                    ;TRILYON_10 ETIKETI
     mov bx , 2                   ;BX' 2 DEGERI YUKLENDI 
     JMP TAKETRILLION               ;TRILYON_AL ETIKETINE DALLANDI
   TRILLION_1:                     ;TRILYON_1 ETIKETI
     mov bx , 1                   ;BX' 1 DEGERI YUKLENDI
         
   TAKETRILLION:                    ;TRILYON_AL
     mov address ,  BP            ;address DEGISKENINE BP DEGERI ATANDI
     TRANSLATE  address               ;CEVIR MAKROSU CAGRILDI
     STRING_YAZ trillion           ;EKRANA trilyon KATARI YAZDIRILDI
     sub cx , bx                  ;CX , BX DEGERI KADAR AZALDI
     add bp , bx                  ;BP , BX DEGERI KADAR ARTIRILDI
     JMP GOBILLION              ;MILYARA_GEC ETIKETINE DALLANDI
     
    BILLION_100:                   ;MILYAR_100 ETIKETI
     mov bx , 3                   ;BX'E  3 DEGERI YUKLENDI
     JMP TAKEBILLION                ;MILYAR_AL ETIKETINE DALLANDI
    BILLION_10:                    ;MILYAR_10 ETIKETI
     mov bx , 2                   ;BX'E  2 DEGERI YUKLENDI
     JMP TAKEBILLION                ;MILYAR_AL ETIKETINE DALLANDI
    BILLION_1:                     ;MILYAR_1 ETIKETI
     mov bx , 1                   ;BX'E  1 DEGERI YUKLENDI
     
    TAKEBILLION:                    ;MILYAR_AL
     mov address ,  BP            ;address DEGISKENINE BP DEGERI ATANDI
     TRANSLATE address                ;CEVIR MAKROSU CAGRILDI
     STRING_YAZ billion            ;EKRANA milyar KATARI YAZDIRILDI
     sub cx , bx                  ;CX , BX DEGERI KADAR AZALDI
     add bp , bx                  ;BP , BX DEGERI KADAR ARTIRILDI
     JMP GOMILLION              ;MILYONA_GEC ETIKETINE DALLANDI
     
     MILLION_100:                  ;MILYON_100 ETIKETI
     mov bx , 3                   ;BX'E  3 DEGERI YUKLENDI
     JMP TAKEMILLION                ;MILYON_AL ETIKETINE DALLANDI
     MILLION_10:                   ;MILYON_10 ETIKETI
     mov bx , 2                   ;BX'E  2 DEGERI YUKLENDI
     JMP TAKEMILLION                ;MILYON_AL ETIKETINE DALLANDI
     MILLION_1:                    ;MILYON_1 ETIKETI
     mov bx , 1                   ;BX'E  1 DEGERI YUKLENDI
     
    TAKEMILLION:                   ;MILYON_AL
     mov address ,  BP            ;address DEGISKENINE BP DEGERI ATANDI
     TRANSLATE address                ;CEVIR MAKROSU CAGRILDI
     STRING_YAZ million            ;EKRANA milyon KATARI YAZDIRILDI
     sub cx , bx                  ;CX , BX DEGERI KADAR AZALDI
     add bp , bx                  ;BP , BX DEGERI KADAR ARTIRILDI
     JMP GOTHOUSAND                 ;BINE_GEC ETIKETINE DALLANDI
     
     THOUSAND_100:                     ;BIN_100 ETIKETI
     mov bx , 3                   ;BX'E 3 DEGERI YUKLENDI
     JMP TAKETHOUSAND                   ;BIN_AL ETIKETINE DALLANDI
     THOUSAND_10:                      ;BIN_10 ETIKETI
     mov bx , 2                   ;BX'E 2 DEGERI YUKLENDI
     JMP TAKETHOUSAND                   ;BIN_AL ETIKETINE DALLANDI
     THOUSAND_1:                       ;BIN_1 ETIKETI
     mov bx , 1                   ;BX'E  1 DEGERI YUKLENDI
     
     TAKETHOUSAND:                      ;BIN_AL
     mov address ,  BP            ;address DEGISKENINE BP DEGERI ATANDI
     TRANSLATE address                ;CEVIR MAKROSU CAGRILDI
     STRING_YAZ bin               ;EKRANA bin KATARI YAZDIRILDI
     sub cx , bx                  ;CX , BX DEGERI KADAR AZALDI
     add bp , bx                  ;BP , BX DEGERI KADAR ARTIRILDI
     JMP GOHUNDRED                 ;YUZE_GEC ETIKETINE DALLANDI
     
     HUNDRED_100:                     ;YUZ_100 ETIKETI
     mov bx , 3                   ;BX'E 3 DEGERI YUKLENDI
     JMP TAKEHUNDRED                   ;YUZ_AL ETIKETINE DALLANDI
     HUNDRED_10:                      ;YUZ_10 ETIKETI
     mov bx , 2                   ;BX'E 2 DEGERI YUKLENDI
     JMP TAKEHUNDRED                   ;YUZ_AL ETIKETINE DALLANDI
     HUNDRED_1:                       ;YUZ_1 ETIKETI
     mov bx , 1                   ;BX'E 1 DEGERI YUKLENDI
     
     TAKEHUNDRED:                      ;YUZ_AL
     mov address ,  BP            ;address DEGISKENINE BP DEGERI ATANDI
     TRANSLATE address                ;CEVIR MAKROSU CAGRILDI
     sub cx , bx                  ;CX , BX DEGERI KADAR AZALDI
     add bp , bx                  ;BP , BX DEGERI KADAR ARTIRILDI    
    
    
     
     MOV AH , 01H                 ;AH <-- 01H KARAKTER AL FONKSIYONU SECILDI
     INT 21H                      ;FONKSIYONUN BULUNDUGU KESME SECILDI
     CMP AL , 0DH                 ;AL DEGERI 0DH ILE KIYASLANDI (ENTER TUSUNA BASILIP BASILMADIGI KONTROL EDILDI)
     MOV counterEn , 00H            ;counter SIFIRLANDI
     
     JE ANAMENUYE_GEC             ;ANAMENUYE_GEC ETIKETINE DADLLANDI
     
     JMP SON                      ;PROGRAMI SONLANDIR   
  
  
 ;************************************************************************************************
 WORD_NUMBER:                      ;YAZI_SAYIYA ETIKETI
     CALL YENI_SATIR              ;CALL KOMUTUYLA YENI_SATIR ALTPROGRAMINI CAGRILDI (YENI SATIRA GECILDI)
     CALL YENI_SATIR              ;YENI SATIRA GECILDI
     STRING_YAZ wordEnter         ;EKRANA yaziGirdi KATARI YAZDIRILDI
     CALL YENI_SATIR              ;YENI SATIRA GECILDI

     TEXT_FROM_USER             ;KULLANICI_YAZI_AL MAKROSU ÇAGRILDI
     CALL YENI_SATIR               ;YENI SATIRA GECILDI
     STRING_YAZ answer              ;EKRANA cevap KATARI YAZDIRILDI
         RESINIT                   ;RES KATARI INITIALIZE EDILDI ('$')
     MOV AX , BP                   ;AX <-- BP
     LEA SI,RES                    ;SI' E RES KATARININ EFEKTIF ADRESI YUKLENDI
     CALL HEX2DEC                  ;CALL KOMUTUYLE HEX2DEC FONKSIYONU ÇAGRILDI
     STRING_YAZ RES                ;EKRANA RES KATARI YAZDIRILDI                     
     
     JMP SON                       ;SON ETIKETINE DALLANDI     
     
 ;************************************************************************************************************
 ARITHMETIC_OPERATION:                   ;ARITMETIC_ISLEM ETIKETI
                                   
     CALL YENI_SATIR               ;CALL KOMUTUYLA YENI_SATIR FONKSIYONU ÇAGRILDI (YENI SATIRA GECILDI)
     CALL YENI_SATIR               ;CALL KOMUTUYLA YENI_SATIR FONKSIYONU ÇAGRILDI (YENI SATIRA GECILDI)
     STRING_YAZ addition            ;EKRANA toplama KATARI YADIRILDI     (TOPLAMA ISLEMI SECENEGI)
     CALL YENI_SATIR               ;CALL KOMUTUYLA YENI_SATIR FONKSIYONU ÇAGRILDI (YENI SATIRA GECILDI)
     STRING_YAZ subtraction            ;EKRANA cikarma KATARI YADIRILDI     (CIKARMA ISLEMI SECENEGI)
     CALL YENI_SATIR               ;CALL KOMUTUYLA YENI_SATIR FONKSIYONU ÇAGRILDI (YENI SATIRA GECILDI)
     MOV  ah , 01h                 ;AH <-- 01 (BIR KARAKTER AL FONKSIYONU SECILDI)
     INT  21h                      ;FONKSIYONUN BUKUNDUGU KESME SECILDI
     CMP  al , '1'                 ;ALINAN KARAKTER(AL DEGERI) '1' ILE KIYASLANDI
     JE   ADDITION_OPERATION       ;'1' ISE TOPLAMA_ISLEMI ETIKETINE DALLANDI 
     CMP  al , '2'                 ;ALINAN KARAKTER(AL DEGERI) '2' ILE KIYASLANDI
     JE   SUBTRACTION_OPERATION          ;'2' ISE CIKARMA_ISLEMI ETIKETINE DALLANDI         
     
     
;*************************************************************************************************************      

ADDITION_OPERATION:                    ;TOPLAMA_ISLEMI ETIKETI
     CALL YENI_SATIR               ;CALL KOMUTUYLA YENI_SATIR FONKSIYONU ÇAGRILDI (YENI SATIRA GECILDI)
     CALL YENI_SATIR               ;CALL KOMUTUYLA YENI_SATIR FONKSIYONU ÇAGRILDI (YENI SATIRA GECILDI)
     STRING_YAZ operand1Enter      ;EKRANA operand1Girdi KATARI YADIRILDI
     CALL YENI_SATIR               ;CALL KOMUTUYLA YENI_SATIR FONKSIYONU ÇAGRILDI (YENI SATIRA GECILDI)
     
     mov tempBxx , 00h              ;tempBx SIFIRLANDI
     TEXT_FROM_USER             ;KULLANICI_YAZI_AL MAKROSU CAGRILDI
     mov c1 , bp                   ;b1 <-- BP 
     mov bp , 00h                  ;BP <-- 00H     
     call YENI_SATIR               ;CALL KOMUTUYLA YENI_SATIR FONKSIYONU ÇAGRILDI (YENI SATIRA GECILDI)
     
     STRING_YAZ operand2Enter     ;EKRANA operand2Girdi KATARI YADIRILDI
     call YENI_SATIR               ;CALL KOMUTUYLA YENI_SATIR FONKSIYONU ÇAGRILDI (YENI SATIRA GECILDI)
     mov tempBxx , 00h
     TEXT_FROM_USER             ;KULLANICI_YAZI_AL MAKROSU CAGRILDI
     mov c2 , bp                   ;b2 <-- BP
     add bp , c1                   ;BP <-- BP +  b1
     mov tempBxx , 00h            
     call YENI_SATIR               ;CALL KOMUTUYLA YENI_SATIR FONKSIYONU ÇAGRILDI (YENI SATIRA GECILDI)
     STRING_YAZ answer              ;EKRANA cevap KATARI YADIRILDI
 
     MOV AX , c1                   ;AX <-- b1 
     LEA SI,RES                    ;SI' E RES KATARININ EFEKTIF ADRESI YUKLENDI
     CALL HEX2DEC                  ;CALL KOMUTUYLA HEX2DEC ALTPROGRAMI CAGRILDI (OPERAND1 DEGERI ONLUGA CEVRILDI)
         STRING_YAZ RES            ;EKRANA RES KATARI YADIRILDI   (ILK OPERANDIN ONLUK DEGERI)
         STRING_YAZ arti           ;EKRANA arti KATARI YADIRILDI  
         RESINIT   
     MOV AX , c2                   ;AX <-- b2
     LEA SI,RES                    ;SI' E RES KATARININ EFEKTIF ADRESI YUKLENDI
     CALL HEX2DEC                  ;CALL KOMUTUYLA HEX2DEC ALTPROGRAMI CAGRILDI (OPERAND2 DEGERI ONLUGA CEVRILDI)
         STRING_YAZ RES            ;EKRANA RES KATARI YADIRILDI   (IKINCI OPERANDIN ONLUK DEGERI)
         STRING_YAZ esit           ;EKRANA arti KATARI YADIRILDI 
         RESINIT
     MOV AX , BP                   ;AX <-- BP  (HEX DEGERI DECIMALE CEVIRMEK UZERE BOLME ISLEMI ICIN)
     LEA SI,RES                    ;SI' E RES KATARININ EFEKTIF ADRESI YUKLENDI
     CALL HEX2DEC                  ;CALL KOMUTUYLA HEX2DEC ALTPROGRAMI CAGRILDI (ISLEM SONUCU DEGERI ONLUGA CEVRILDI)
         STRING_YAZ RES            ;EKRANA RES KATARI YADIRILDI   (TOPLAMA SONUCUNUN ONLUK DEGERI)

     JMP SON                       ;SON ETIKETINE DALLANDI (PROGRAM SONLANDIRILDI)     
     

 
SUBTRACTION_OPERATION:                    ;CIKARMA_ISLEMI
 
     CALL YENI_SATIR               ;CALL KOMUTUYLA YENI_SATIR FONKSIYONU ÇAGRILDI (YENI SATIRA GECILDI)
     CALL YENI_SATIR               ;CALL KOMUTUYLA YENI_SATIR FONKSIYONU ÇAGRILDI (YENI SATIRA GECILDI)
     STRING_YAZ operand1Enter     ;EKRANA operand1Girdi KATARI YADIRILDI
     CALL YENI_SATIR               ;CALL KOMUTUYLA YENI_SATIR FONKSIYONU ÇAGRILDI (YENI SATIRA GECILDI)
     TEXT_FROM_USER            ;KULLANICI_YAZI_AL MAKROSU CAGRILDI
     MOV c1 , BP                   ;b1 <-- BP
     MOV BP , 00h                  ;BP <-- 00H
     
     CALL YENI_SATIR               ;CALL KOMUTUYLA YENI_SATIR FONKSIYONU ÇAGRILDI (YENI SATIRA GECILDI)
     STRING_YAZ operand2Enter      ;EKRANA operand2Girdi KATARI YADIRILDI
     CALL YENI_SATIR               ;CALL KOMUTUYLA YENI_SATIR FONKSIYONU ÇAGRILDI (YENI SATIRA GECILDI)
     mov tempBxx , 00h              ;tempBx SIFIRLANDI
     TEXT_FROM_USER             ;KULLANICI_YAZI_AL MAKROSU CAGRILDI  
     CALL YENI_SATIR               ;CALL KOMUTUYLA YENI_SATIR FONKSIYONU ÇAGRILDI (YENI SATIRA GECILDI)
     STRING_YAZ answer              ;EKRANA cevap KATARI YAZDIRILDI
     MOV c2 , BP                   ;b2 <-- BP
     MOV AX , c1                   ;AX <-- b1   
        RESINIT
     LEA SI,RES                    ;KULLANICI_YAZI_AL MAKROSU CAGRILDI
     CALL HEX2DEC                  ;CALL KOMUTUYLA HEX2DEC ALTPROGRAMI CAGRILDI (OPERAND1 DEGERI ONLUGA CEVRILDI)
         STRING_YAZ RES            ;EKRANA RES KATARI YADIRILDI
         STRING_YAZ eksi           ;EKRANA eksi KATARI YADIRILDI
     MOV AX , c2                   ;AX <-- b2
         RESINIT
     LEA SI,RES                    ;SI' E RES KATARININ EFEKTIF ADRESI YUKLENDI
     CALL HEX2DEC                  ;CALL KOMUTUYLA HEX2DEC ALTPROGRAMI CAGRILDI (OPERAND2 DEGERI ONLUGA CEVRILDI)
         STRING_YAZ RES            ;EKRANA RES KATARI YADIRILDI
         STRING_YAZ esit           ;EKRANA RES KATARI YADIRILDI     
     CMP BP , c1                   ;b1 ILE BP KIYASLANDI
     JA  c2Buyuk                   ;b2Buyuk ETIKETINE DALLANDI (b2/BP BUYUK OLDUGU DURUM)
      SUB c1 , BP                  ;b1 <-- B1 - BP
      MOV BP , c1                  ;BP <-- b1
      JMP cpp                      ;bpp ETIKETINE DALLANDI
     c2Buyuk:                      ;b2Buyuk ETIKETI
      SUB BP , c1                  ;BP <-- BP - b1
         STRING_YAZ eksi           ;EKRANA eksi KATARI YADIRILDI 
      
     cpp:                          ;bpp ETIKETI  
         RESINIT
      MOV AX , BP                  ;AX <-- BP
      LEA SI,RES                   ;SI' E RES KATARININ EFEKTIF ADRESI YUKLENDI
      CALL HEX2DEC                 ;CALL KOMUTUYLA HEX2DEC ALTPROGRAMI CAGRILDI (CIKARMA SONUCUNUN DEGERI ONLUGA CEVRILDI)
         STRING_YAZ RES            ;EKRANA RES KATARI YADIRILDI  
       
JMP SON                   
                                
                          
                                                                                   
;***************   YENI SATIRA GECMEYE YARAYAN PROCEDURE   *******************;    

YENI_SATIR PROC NEAR               ;ALTPROGRAMI TANIMLA
     LEA DX , new_line             ;DX' new_line degiskenin ADRESINI YUKLE
     mov ah , 09H                  ;KATARI YAZAN FONKSIYON'U SEC
     INT 21H                       ;KATAR FONKSIYONU BULUNDUGU INTERRUPT
YENI_SATIR ENDP                    ;ALTPROGRAMI SONLANDIR


;********* HEXADECIMAL SAYIYI DECIMAL SAYIYA CEVIREN FONKSIYON ***************;

HEX2DEC PROC NEAR                  ;HEX2DEC ADIYLA ALTPROGRAMI TANIMLANDI
       MOV CX,0                    ;CX' E 0  DEGERI YUKLENDI
       MOV BX,10                   ;BX' E 10 DEGERI YUKLENDI 
   
LOOP1: MOV DX,0                    ;LOOP1 ETIKETI  DX <-- 00H
       DIV BX                      ;AX <-- AX / BX
       ADD DL,30H                  ;DL <-- DL + 30H
       PUSH DX                     ;DX DEGERI STACK' E ATILDI
       INC CX                      ;CX DEGERI 1 ARTIRILDI
       CMP AX,9                    ;AX DEGERI 9 ILE KIYASLANDI
       JG LOOP1                    ;LOOP1 ETIKETINE DALLANDI
     
       ADD AL,30H                  ;AL <-- AL + 30H
       MOV [SI],AL                 ;[SI] BELLEK GOZUNE SL DEGERI ATILDI
     
LOOP2: POP AX                      ;STACK'TEN AX' E YUKLENDI
       INC SI                      ;SI' I BIR ARTIRILDI
       MOV [SI],AL                 ;[SI] BELLEK GOZUNE AL DEGERI YERLESTIRILDI
       LOOP LOOP2                  ;LOOP2 ETIKETINE DALLANDI
       RET                         ;PROGRAM ALTPROGRAMDAN DONDU
HEX2DEC ENDP                       ;ALTPROGRAM SONLANDIRILDI
SON:                               ;SON ETIKETINE
   
   .EXIT 0                         ;PROGRAM SONLANDIRILDI
   
ret                                ;PROGRAM AKISI SISTEME DÖNDÜRÜLDÜ
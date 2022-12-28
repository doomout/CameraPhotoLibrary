# 카메라와 포토 앱
카메라와 포토 앱이란?  
카메라를 이용하여 찍은 사진이나 비디오는 포토 라이브러리에 저장되고 이렇게 저장된 사진이나 비디오를 포토 라이브러리에서 불러올 수 있다.        
또한 사진을 편집한 후 포토 라이브러리에 저장할 수도 있다.  
포토 라이브러리는 사진 앱의 앨범을 의미하기에 사진이나 비디오를 찍은 후 사진 앱의 앨범에서 확인할 수 있다.

변경점 
예제에 있는 kUTTypeImage는 15버전 부터는 사용하지 말라는 경고가 나온다. 
'kUTTypeImage' was deprecated in iOS 15.0: Use UTTypeImage instead.     
대신 UTTypeImage를 사용하라고 권장한다.  
UTTypeImage의 사용법은 다음과 같다.  

import UniformTypeIdentifiers 

//이미지와 동영상을 나눠 놨다.
이미지 일 때 : kUTTypeImage  -> UTType.image.identifier 
동영상 일 때 : kUTTypeImage  -> UTType.movie.identifier 

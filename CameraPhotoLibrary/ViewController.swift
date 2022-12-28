
import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    var captureImage : UIImage! //촬영하거나 포토 라이브러리에서 불러온 사진을 저장할 함수
    var videoURL : URL! //녹화한 비디오의 URL을 저장할 변수
    var flagImageSave = false //이미지 저장 여부를 나타낼 변수
    
    @IBOutlet var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    //사진 촬영
    @IBAction func btnCaptureImageFromCamera(_ sender: UIButton) {
        //카메라의 사용 가능 여부를 확인. 사용 가능할 때~
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            flagImageSave = true //이미지 저장을 허용
            imagePicker.delegate = self //이미지 피커의 델리데이트를 self 로 설정
            imagePicker.sourceType = .camera //이미지 피커의 소스 타입을 camera로 설정
            imagePicker.mediaTypes = [UTType.image.identifier as String] //미디어 타입 설정
            imagePicker.allowsEditing = false //편집은 허용하지 않음
            
            //현재 뷰 컨트롤러를 이미지피커로 대체
            present(imagePicker, animated: true, completion: nil)
        } else {
            myAlert("Camera inaccessable", message: "Application cannot access the camera.")
        }
    }
    //사진 불러오기
    @IBAction func btnLoadImageFromLibrary(_ sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            flagImageSave = false
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [UTType.image.identifier as String] //kUTTypeImage 사용 부라
            imagePicker.allowsEditing = true //편집 허용
            
            present(imagePicker, animated: true, completion: nil)
        } else {
            myAlert("Photo album inaccessable", message: "Application cannot access the photo album.")
        }
    }
    
    //비디오 촬영
    @IBAction func btnRecordVideoFromCamera(_ sender: UIButton) {
        //카메라의 사용 가능 여부를 확인. 사용 가능할 때~
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            flagImageSave = true //이미지 저장을 허용
            imagePicker.delegate = self //이미지 피커의 델리데이트를 self 로 설정
            imagePicker.sourceType = .camera //이미지 피커의 소스 타입을 camera로 설정
            imagePicker.mediaTypes = [UTType.image.identifier as String] //미디어 타입 설정
            imagePicker.allowsEditing = false //편집은 허용하지 않음
            
            //현재 뷰 컨트롤러를 이미지피커로 대체
            present(imagePicker, animated: true, completion: nil)
        } else {
            myAlert("Camera inaccessable", message: "Application cannot access the camera.")
        }
    }
    
    //비디오 불러오기
    @IBAction func btnLoadVideoFromLibrary(_ sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            flagImageSave = false
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [UTType.movie.identifier  as String]
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        } else {
            myAlert("Photo album inaccessable", message: "Application cannot access the photo album.")
        }
    }
    
    func myAlert(_ title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    //사진이나 비디오를 촬영하거나 포토 라이브러리에서 선택이 끝났을 떄 호출되는 함수
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //미디어 종류 확인
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
        
        if mediaType.isEqual(to: UTType.image.identifier as NSString as String) { //미디어 종류가 사진일 경우
            //사진을 가져와 저장한다
            captureImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            
            
            if flagImageSave {
                UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil)
            }
            
            imgView.image = captureImage
        } else if mediaType.isEqual(to: UTType.movie.identifier  as NSString as String) { //미디어 종류가 비디오라면
            //이미지가 저장된 상태라면 가져온 동영상을 포토 라이브에 저장한다.
            if flagImageSave {
                videoURL = (info[UIImagePickerController.InfoKey.mediaURL] as! URL)
                
                UISaveVideoAtPathToSavedPhotosAlbum(videoURL.relativePath, self, nil, nil)
            }
        }
        //현재의 뷰 컨트롤러를 제거한다. 뷰에서 이미 피커 화면을 제거하여 초기 뷰를 보여준다.
        self.dismiss(animated: true, completion: nil)
    }
    
    //사진이나 비디오를 찍지 않고 취소하거나 선택하지 않고 ㅊ취소할 떄 호출되는 함수
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}


//
//ContentView.swift
//  Shared
//
//  Created by Kuniaki Ohara on 2021/01/06.
//
/*
import SwiftUI
import AVFoundation


struct CALayerView: UIViewControllerRepresentable {
  typealias UIViewControllerType = UIViewController
  var caLayer: CALayer

  func makeUIViewController(context: Context) -> UIViewController {
      let viewController = UIViewController()
      viewController.view.layer.addSublayer(caLayer)
      caLayer.frame = viewController.view.layer.frame
      return viewController
  }

  public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
      caLayer.frame = uiViewController.view.layer.frame
  }
}


class CameraController : NSObject, AVCapturePhotoCaptureDelegate, ObservableObject{
  private (set) public var HasImage = false
  @Published private (set) public var Image: UIImage?
  private (set) public var progress: Int = 0
  @Published private (set) public var ImageSize: CGSize = CGSize(width: 1.0, height: 1.0)
  private (set) public var captureSession = AVCaptureSession()
  private (set) public var currentDevice: AVCaptureDevice?
  private (set) public var subDevice: AVCaptureDevice?
  private (set) public var capturePhotoOutput : AVCapturePhotoOutput?
  private (set) public var usingSubDevice = false
  @Published private (set) public var cameraPreviewLayer : AVCaptureVideoPreviewLayer?
  private (set) public var emptyImage = UIImage(named: ConstHolder.PROCESSINGMASKNAME)
  public var CALayer : CALayer {
      get{
          if (cameraPreviewLayer == nil){
              let caLayer: CALayer = QuartzCore.CALayer()
              caLayer.contents = emptyImage!.resize(size: ImageSize)!.cgImage
              return caLayer
          }
          
          return cameraPreviewLayer!
      }
  }
  
  func setupCaptureSession(session: AVCaptureSession) {
      session.sessionPreset = AVCaptureSession.Preset.photo //可能な限り最高画質で撮る
  }
  
  func getDevices() -> (AVCaptureDevice?, AVCaptureDevice?) {
      let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInTelephotoCamera, AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified) //ズームカメラ使用
      // プロパティの条件を満たしたカメラデバイスの取得
      let devices = deviceDiscoverySession.devices

      var mainCamera: AVCaptureDevice? = nil
      var innerCamera: AVCaptureDevice? = nil
      
      for device in devices {
          if device.position == AVCaptureDevice.Position.back {
              mainCamera = device
          } else if device.position == AVCaptureDevice.Position.front {
              innerCamera = device
          }
      }
            
      return (mainCamera, innerCamera)
  }
  
  func setupInputOutput(session: AVCaptureSession, device: AVCaptureDevice?) {
      do {
          // 指定したデバイスを使用するために入力を初期化
          let captureDeviceInput = try AVCaptureDeviceInput(device: device!)
          // 指定した入力をセッションに追加
          session.addInput(captureDeviceInput)
          // 出力データを受け取るオブジェクトの作成
          capturePhotoOutput = AVCapturePhotoOutput()
          // 出力ファイルのフォーマットを指定
          capturePhotoOutput!.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecType.jpeg])], completionHandler: nil)
          session.addOutput(capturePhotoOutput!)
      } catch {
          print(error)
      }
  }
  
  func setupPreviewLayer(session: AVCaptureSession?) {
      if (session != nil){
          // 指定したAVCaptureSessionでプレビューレイヤを初期化
          self.cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: session!)
          // プレビューレイヤが、カメラのキャプチャーを縦横比を維持した状態で、表示するように設定
          self.cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
          // プレビューレイヤの表示の向きを設定
          self.cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.landscapeRight
      }
  }

  
  public override init(){
      super.init()
          
      setupCaptureSession(session: self.captureSession)
      let (mainCamera, inCamera) = getDevices()
      self.currentDevice = mainCamera
      self.subDevice = inCamera
      if (self.currentDevice != nil){
          setupInputOutput(session: self.captureSession, device: mainCamera)
          setupPreviewLayer(session: self.captureSession)
      }
      
      // For Screen Rotation Initialize
      OrientationChanged(notification: Notification(name: UIDevice.orientationDidChangeNotification))

      // For Screen Rotation
      NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: nil, using: OrientationChanged)
  }
  
    
    
  public func set(zoom: CGFloat){
      let resolvedScale = 3.0 //magnification
      let device = self.captureDeviceInput.device
    
      do {
          try device.lockForConfiguration()
          device.videoZoomFactor = resolvedScale
          device.unlockForConfiguration()
      }
      catch {
          print(error.localizedDescription)
      }
      }
    
    
    
  // CAUTION !!! UIDevice.current.orientation does NOT work for initialization !!!
  // Use interfaceOrientation instead!!!!
  public func OrientationChanged(notification: Notification){
      switch UIApplication.shared.windows.first?.windowScene?.interfaceOrientation{
      case .portrait:
          self.cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
      case .portraitUpsideDown:
          self.cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portraitUpsideDown
      case .landscapeLeft:
          self.cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.landscapeLeft
      case .landscapeRight:
          self.cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.landscapeRight
      default:
          break
      }
  }
  
  // delegate in swift nearly equals EventListener in java
  public func TakePhoto(progress: Double){
      self.progress = Int(progress)
      
      //カメラデバイスのない状況でのデバッグ用
      if (self.capturePhotoOutput == nil){
          setImage(progress: self.progress, cgImage: emptyImage!.resize(size: ImageSize)!.cgImage!)
          return
      }
      
      let photoSetting = AVCapturePhotoSettings()
      self.capturePhotoOutput?.capturePhoto(with: photoSetting, delegate: self)
  }
  
  public func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
      let imageData = photo.fileDataRepresentation()
      let imageOrientation = getImageOrientation()
      let cgImage = UIImage(data: imageData!)!.cgImage!.cropToSquare()
      var rawImage = UIImage(cgImage: cgImage).rotatedBy(orientation: imageOrientation)
      if self.usingSubDevice{
          rawImage = rawImage.flipHorizontal()
      }
      
      setImage(progress: self.progress, cgImage: rawImage.cgImage!)
  }
  
  private func setImage(progress: Int, cgImage: CGImage){
      ResultHolder.GetInstance().SetImage(index: progress, cgImage: cgImage)
      updateImage(cgImage: cgImage)
  }
  
  func updateImage(cgImage: CGImage?){
      let rotatedImage = UIImage(cgImage: cgImage!)
      let resizedImage = rotatedImage.resizeFill(size: self.ImageSize)
      let left = (resizedImage!.size.width - self.ImageSize.width) / 2
      let top = (resizedImage!.size.height - self.ImageSize.height) / 2
      self.Image = resizedImage?.crop(to: CGRect(x: left, y: top, width: self.ImageSize.width, height: self.ImageSize.height))
  }
  
  func getImageOrientation() -> UIImage.Orientation{
      var imageOrientation = UIImage.Orientation.up
      
      if self.usingSubDevice{
          switch UIApplication.shared.windows.first?.windowScene?.interfaceOrientation{
          case .portrait:
              imageOrientation = UIImage.Orientation.right
          case .portraitUpsideDown:
              imageOrientation = UIImage.Orientation.left
          case .landscapeLeft:
              imageOrientation = UIImage.Orientation.up
          case .landscapeRight:
              imageOrientation = UIImage.Orientation.down
          default:
              print("taken image unknown orientation")
              break
          }
          return imageOrientation
      }
      
      switch UIApplication.shared.windows.first?.windowScene?.interfaceOrientation{
      case .portrait:
          imageOrientation = UIImage.Orientation.right
      case .portraitUpsideDown:
          imageOrientation = UIImage.Orientation.left
      case .landscapeLeft:
          imageOrientation = UIImage.Orientation.down
      case .landscapeRight:
          imageOrientation = UIImage.Orientation.up
      default:
          print("taken image unknown orientation")
          break
      }
      
      return imageOrientation
  }
  
  public func ShowPhoto(progress: Double) -> Bool{
      let intProgress = Int(progress)
      let image = ResultHolder.GetInstance().Images[intProgress]
      if (image == nil) {
          return false
      }
      
      updateImage(cgImage: image!)
      return true
  }
  
  public func ResetPhoto(){
      self.Image = nil
  }
  
  public func SetImageSize(screenSize: CGSize){
      let shorterSide = (screenSize.width < screenSize.height) ? screenSize.width : screenSize.height
      let sideSize = ConstHolder.IMAGESCALE * shorterSide
    self.ImageSize = CGSize(width: sideSize, height: ConstHolder.HWRATIO * sideSize)
  }
  
  //インカメラへの切り替え
  public func SwitchDevice(){
      if (subDevice == nil) {
          print("incamera is nil")
          return
      }
      self.usingSubDevice = !self.usingSubDevice
      let temp = currentDevice
      currentDevice = subDevice
      subDevice = temp
      self.captureSession.stopRunning()
      self.captureSession = AVCaptureSession()
      setupCaptureSession(session: self.captureSession)
      setupInputOutput(session: self.captureSession, device: currentDevice)
      //self.cameraPreviewLayer?.session = self.captureSession
      setupPreviewLayer(session: self.captureSession)
      self.captureSession.startRunning()
      
      // For Screen Rotation Initialize
      OrientationChanged(notification: Notification(name: UIDevice.orientationDidChangeNotification))
  }
}
 */

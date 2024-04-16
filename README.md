# 📚생일책

<picture>![App Icon_125](https://github.com/jieun0330/BirthdayBook/assets/42729069/202ac6f4-f096-49ef-8bb6-1b6f3b79c651)</picture>

2024년 3월 7일 ~ 24일 (`2주`)
> 최신 버전 : 1.0.3 - 2024년 4월 9일 (업데이트 진행중)

내 생일에, 내가 사랑하는 사람의 생일에는 어떤 책이 태어났을까요?

나와 생일이 같은 책들을 확인하고, 특별하고 의미있는 생일을 책으로 축하해줄 수 있습니다

Appstore: https://apps.apple.com/kr/app/id6479728983

|<picture>![KakaoTalk_Photo_2024-04-13-14-03-56](https://github.com/jieun0330/BirthdayBook/assets/42729069/6be2cafc-db64-4252-8109-4ff7eb24dc94)</picture>|<picture>![665x1440_2](https://github.com/jieun0330/BirthdayBook/assets/42729069/2f5306c9-d904-4aa5-ab69-475587bfb7d1)</picture>|<picture>![665x1440_1](https://github.com/jieun0330/BirthdayBook/assets/42729069/1a4f50f8-96d2-40db-bcce-308e8f3a1e0a)</picture>|<picture>![665x1440_3](https://github.com/jieun0330/BirthdayBook/assets/42729069/b0b87414-4665-41a1-bc0a-ab34f1203f29)</picture>
|---|---|---|---|

<br/>

## 🔨핵심기능
* `도서 검색` 날짜로 해당 날짜에 발행된 도서 검색 - 국립중앙도서관 API
* `도서 검색` 알라딘 API를 통한 도서 검색 및 베스트셀러 제공
* `북마크` 소장하고싶거나 읽고싶은 책에 대한 북마크 저장/삭제 기능
* `구매 기능` 구매할 수 있는 알라딘 링크로 연결

<br/>

## 🛠️ Skills
**User Interface**
* `UIKit(Code Base)`
* `SnapKit`
* `FlowLayout` 

**Library**
* `FSCalendar` 메인 화면의 주된 기능을 활용하기 위해 사용
* `Kingfisher` 책 이미지를 다운로드 하기 위해 이미지 캐싱을 손쉽게 해주는 라이브러리 사용

**Network**
* `Codable` Decodable 프로토콜을 통해 Json 응답값 처리
* `Alamofire` Router 패턴을 통한 API 호출

**DataBase**
* `Realm` 책 제목, 저자, 이미지 테이블 구성 및 CRUD 구현

**Design Pattern**
* `MVVM` 비즈니스 로직과 UI 로직을 구분
* `Router` 네트워크 통신을 위한 로직 추상화
* `DesignSystem` 열거형을 활용하여 디자인 시스템 요소 정리
* `Access Control` 접근제어자를 통해 컴파일 타임 활용
* `Singleton` 
* `Custom Observable`
* `Repository`

<br/>

## 🔧 Trouble Shooting

### **1️⃣ API 연쇄 호출로 인한 Reload 횟수 과다 실행**

**❌ 문제 상황**: 알라딘 API 호출시 호출 횟수만큼 Reload 실행

**⭕️ 해결 방법**
1. ViewModel 안에서 네트워크 결과를 받아온 후 보여지는 방식으로 reload 횟수를 줄이게끔 해결
2. 성공 케이스와 실패 케이스를 더해서 갯수를 파악하고 보여지는 식으로 수정
3. 첫번째 API 호출(국립중앙도서관)에서 얻은 결과값을 두번째 API 호출(알라딘)의 Trigger로 활용

<details>
<summary>Code</summary>

```
import Foundation 

final class CalendarViewModel {
    
    var inputDate = Observable("")
    var inputISBNTrigger: Observable<Void?> = Observable(nil)
    var inputIndicatorTrigger = Observable(false)
    
    var outputNationalLibraryAPIResult: [String] = []
    var outputAladinAPIResult: Observable<[Item]> = Observable([])
    var outputErrorMessage = Observable("")
    
    init() {
        
        self.inputDate.bind { [weak self] bookDate in
            guard let self else { return }
            
            // Indicator Start animating
            self.inputIndicatorTrigger.value = true
            
            APIManager.shared.nationalLibraryCallRequest(api: .dateLibrary(date: bookDate)) {
                [weak self] result in
                guard let self else { return }
                
                // Indicator stop animating
                self.inputIndicatorTrigger.value = false
                
                switch result {
                case .success(let success):
                    for isbn in success.docs {
                        if !isbn.isbn.isEmpty {
                            self.outputNationalLibraryAPIResult.append(isbn.isbn)
                        }
                    }
                    self.inputISBNTrigger.value = ()
                case .failure(let failure):
                    
                    if !failure.isResponseSerializationError {
                        self.outputErrorMessage.value = "잠시 후 다시 시도해주세요"
                    }
                }
            }
        }
        
        self.inputISBNTrigger.bind { [weak self] _ in
            guard let self else { return }
            
            let isbnSlice = self.outputNationalLibraryAPIResult.prefix(15)
            var aladinSuccessItem: [Item] = []
            var failureCount = 0
            
            for isbn in isbnSlice {
                APIManager.shared.aladinCallRequest(api: .isbnAladin(isbn: isbn)) {
                    [weak self] result in
                    guard let self else { return }
                    
                    switch result {
                    case .success(let success):
                        
                        aladinSuccessItem.append(contentsOf: success.item)
                        
                        if aladinSuccessItem.count + failureCount == isbnSlice.count {
                            self.outputAladinAPIResult.value.append(contentsOf: aladinSuccessItem)
                        }
                        
                    case .failure(let failure):
                        failureCount += 1
                        if !failure.isResponseSerializationError {
                            self.outputErrorMessage.value = "잠시 후 다시 시도해주세요"
                        }
                        print(failure)
                    }
                }
            }
            if self.outputNationalLibraryAPIResult.count > 15 {
                self.outputNationalLibraryAPIResult.removeSubrange(0...14)
            } else {
                self.outputNationalLibraryAPIResult.removeAll()
            }
        }
    }
}

```
</details>

<br/>

### **2️⃣ API 결과물과 Realm 저장 결과물 통합**

**❌ 문제 상황**: 두 데이터의 로딩 방식

**⭕️ 해결 방법**
- 동일한 정보를 제공하는 두 데이터 소스를 서로 다른 방식으로 로딩하기 위해 오버로딩 구현
- 두개의 메서드를 제네릭으로 전환하여 하나의 함수로 통합

<details>
<summary>Code</summary>

```
func configure<T: BookDataProtocol>(data: T) {

    viewModel.configure(data: data)
    viewModel.configure(dataID: data.title)

    bookBackgroundImg.kf.setImage(with: URL(string: data.cover))
    bookCoverImg.kf.setImage(with: URL(string: data.cover), options: [.transition(.fade(1))])
    bookTitle.text = data.title
    author.text = data.author
    bookDescription.text = String(htmlEncodedString: data.bookDescription)
    vc.bookISBN = data.itemId

    // realm에 있는지 확인
    if viewModel.isBookMarked() {
        bookMarkButton.image = .bookmarkIcon
    } else {
        bookMarkButton.image = .bookmarkIconInactive
    }
}
```
</details>

<br/>

<details>

<summary>프로젝트 후기</summary>

프로젝트를 시작하기 전 API 사전 조사의 중요성을 깨달았다. 날짜를 기준으로 책 정보를 검색할 수 있는 API는 국립중앙도서관이 유일했기 때문에 이를 통해 프로젝트를 시작했다. 하지만 국립중앙도서관 API를 사용하면서 책 이미지 데이터의 부족함을 느꼈고, 이로 인해 사용자에게 보여줄 수 있는 책 이미지 범위가 제한되는 문제를 직면했다. 국립중앙도서관 API에서 제공하는 책 정보 중 책 이미지 URL을 포함하고 있는 데이터가 많지 않았기 때문이다. 이로 인해 이미지가 있는 책들만 배열에 넣고 보여주는 방식으로 진행했지만 검색화면(SearchView)을 구현하는 과정 중에 데이터의 양이 크게 제한되는 결과를 초래했다.

국립중앙도서관 API의 한계를 극복하기 위해, 날짜를 클릭 시 국립중앙도서관 API에서 ISBN만을 추출하여 이를 알라딘 API에서 재검색하는 방식으로 전환했고, 알라딘 API로 책 제목, 저자, 이미지 등 풍부한 정보로 인해 더 만족스러운 검색 결과를 구현할 수 있었다. API에 대해 정보를 더 갖고있었다면 시간이 단축될 수 있을거라고 생각한다.
</details>

#### 업데이트 사항

- [ ]  Realm Notification Token
- [ ]  Network StatusCode Error Handling
- [ ]  DTO 적용
- [ ]  Memory Leak 확인
- [ ]  Launch Screen
- [ ]  본인 생일 입력 → Push Notification
- [ ]  Realm PK Key 수정

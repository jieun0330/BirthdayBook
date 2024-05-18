# 📚생일책

<picture>![App Icon_125](https://github.com/jieun0330/BirthdayBook/assets/42729069/202ac6f4-f096-49ef-8bb6-1b6f3b79c651)</picture>

### 나와 생일이 같은 책들을 확인할 수 있는 앱 '생일책'
* `도서 검색` 날짜로 해당 날짜에 발행된 도서 검색 (국립중앙도서관 API)
* `도서 검색` 알라딘 API를 통한 도서 검색 및 베스트셀러 제공
* `북마크` 소장하고싶거나 읽고싶은 책에 대한 북마크 저장/삭제 기능
* `구매 기능` 구매할 수 있는 알라딘 링크로 연결

<br/>

### 앱스토어([링크](https://apps.apple.com/kr/app/id6479728983))
|<picture>![KakaoTalk_Photo_2024-04-13-14-03-56](https://github.com/jieun0330/BirthdayBook/assets/42729069/6be2cafc-db64-4252-8109-4ff7eb24dc94)</picture>|<picture>![665x1440_2](https://github.com/jieun0330/BirthdayBook/assets/42729069/2f5306c9-d904-4aa5-ab69-475587bfb7d1)</picture>|<picture>![665x1440_1](https://github.com/jieun0330/BirthdayBook/assets/42729069/1a4f50f8-96d2-40db-bcce-308e8f3a1e0a)</picture>|<picture>![665x1440_3](https://github.com/jieun0330/BirthdayBook/assets/42729069/b0b87414-4665-41a1-bc0a-ab34f1203f29)</picture>
|---|---|---|---|

<br/>

## 🔨 개발기간
2024년 3월 7일 ~ 24일 (약 2주, 업데이트 진행중)
> 최신 버전 : 1.0.5 - 2024년 5월 7일



<br/>

## 🛠️ 사용기술 및 라이브러리
`UIKit(Code Base)` `MVVM` `Custom Observable` `SnapKit` `FlowLayout` `FSCalendar` `Kingfisher` `Alamofire` `Realm`
  
<br/>

## ⛏️ Trouble Shooting

**❌ 문제 상황**
<br/>
국립중앙도서관 API의 책 이미지 데이터의 부족, 이로 인해 책 이미지 범위가 제한되는 문제를 직면(책 정보 중 책 이미지 URL을 포함하고 있는 데이터 부족)

**⭕️ 해결 방법**
- 날짜를 클릭 시 국립중앙도서관 API에서 ISBN만을 추출
- 이를 알라딘 API에서 재검색하는 방식으로 전환
- 알라딘 API로 책 제목, 저자, 이미지 등 풍부한 정보로 인해 검색 결과를 구현 

```swift
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
```
<br/>

**❌ 문제 상황**
<br/>
뷰에 보여지는 날짜와 클릭한 날짜가 같을 시 네트워크 중복 호출

**⭕️ 해결 방법**
- 날짜 선택 시 콜백되는 didSelect와 shouldSelect 메소드 두개 활용
- didSelect: 날짜가 선택될 때 선택된 날짜를 저장
- shouldSelect: 다른 날짜를 선택할 때 기존 날짜를 초기화, 같은 날짜를 선택 시 구현 방지

```swift
func calendar(_ calendar: FSCalendar,
              didSelect date: Date,
              at monthPosition: FSCalendarMonthPosition) {
    selectedDate = date
    birthdayDate(date: date)
    viewModel.inputIndicatorTrigger.value = true
}

func calendar(_ calendar: FSCalendar,
              shouldSelect date: Date,
              at monthPosition: FSCalendarMonthPosition) -> Bool {
    if date != selectedDate {
        collectionView.scrollsToTop = true
        APIManager.shared.bookISBNArray.removeAll()
        viewModel.outputAladinAPIResult.value.removeAll()
    } else {
        return false
    }
    return true
}
```

## 🔧 추후 업데이트 사항

- [ ]  Realm Notification Token
- [ ]  Network StatusCode Error Handling
- [ ]  DTO 적용
- [ ]  Memory Leak 확인
- [ ]  Launch Screen
- [ ]  본인 생일 입력 → Push Notification
- [ ]  Realm PK Key 수정

<br/>

## 👏🏻 회고

프로젝트를 시작하기 전 API 사전 조사의 중요성을 깨달았다. 날짜를 기준으로 책 정보를 검색할 수 있는 API는 국립중앙도서관이 유일했기 때문에 이를 통해 프로젝트를 시작했다. 하지만 국립중앙도서관 API를 사용하면서 책 이미지 데이터의 부족함을 느꼈고, 이로 인해 사용자에게 보여줄 수 있는 책 이미지 범위가 제한되는 문제를 직면했다. 국립중앙도서관 API에서 제공하는 책 정보 중 책 이미지 URL을 포함하고 있는 데이터가 많지 않았기 때문이다. 이로 인해 이미지가 있는 책들만 배열에 넣고 보여주는 방식으로 진행했지만 검색화면(SearchView)을 구현하는 과정 중에 데이터의 양이 크게 제한되는 결과를 초래했다.

국립중앙도서관 API의 한계를 극복하기 위해, 날짜를 클릭 시 국립중앙도서관 API에서 ISBN만을 추출하여 이를 알라딘 API에서 재검색하는 방식으로 전환했고, 알라딘 API로 책 제목, 저자, 이미지 등 풍부한 정보로 인해 더 만족스러운 검색 결과를 구현할 수 있었다. 



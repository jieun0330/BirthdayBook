# 📚생일책

<picture>![App Icon_125](https://github.com/jieun0330/BirthdayBook/assets/42729069/202ac6f4-f096-49ef-8bb6-1b6f3b79c651)</picture>

### 나와 생일이 같은 책들을 확인할 수 있는 앱 '생일책'
* 국립중앙도서관 API를 활용한 발행일 기반 도서 검색
  * 사용자가 입력한 날짜를 기반으로 국립중앙도서관 API를 호출하여 해당 날짜에 발행된 도서 정보 검색
  * 검색된 도서 정보(제목, 작가, 출판일 등) 제공
* 알라딘 API를 통한 도서 검색 및 베스트셀러 제공
  * 검색어에 관련된 도서 목록 제공
  * 실시간으로 업데이트되는 알라딘 베스트셀러 목록 제공
* Realm 데이터베이스를 활용한 북마크 기능 구현
  * 소장하고 싶거나 읽고 싶은 책에 대한 북마크 정보를 Realm 데이터베이스에 영구적으로 저장
  * 사용자의 편의를 위해 간단하고 직관적인 방법으로 북마크 저장/삭제 기능 제공

<br/>

### 앱스토어([링크](https://apps.apple.com/kr/app/id6479728983))
![Group 517167394](https://github.com/jieun0330/BirthdayBook/assets/42729069/f48fb790-f979-4f0a-a6e7-aa48b8586ec8)


<br/>

## 🔨 개발기간
2024년 3월 7일 ~ 24일 (약 2주, 업데이트 진행중)
> 최신 버전 : 1.0.7 - 2024년 6월 7일

<br/>

## ⚙️ 앱 개발 환경
- 최소 버전: iOS 17.2
- iPhone SE ~ iPhone 15 Pro Max 기기 대응


<br/>

## 🛠️ 사용기술 및 라이브러리
`UIKit(Code Base)` `MVVM` `Custom Observable` `FlowLayout` `FSCalendar` `Kingfisher` `Alamofire` `Realm` `Then`
<br/>
`국립중앙도서관 API` `알라딘 API`
  
<br/>

## 🔧 구현 고려사항
- `final` 클래스로 상속 및 재정의 방지
- `private` 변수를 선언하여 객체의 캡슐화 강화
- ViewModel을 통해 UI로직과 비즈니스 로직 분리
- Input/Output 패턴을 통해 데이터의 흐름을 명확하게 구현
- 클로저 내부의 약한 참조를 통한 메모리 누수 방지
- Trigger에 바인딩된 Indicator를 사용하여 비동기 작업에 맞춰 로딩상태 표시
- 중복된 API 호출을 방지로 네트워크 자원 효율적 사용
- 공통 로직 메서드 분리를 통한 API 호출 코드 중복 최소화


  
<br/>

## ⛏️ Trouble Shooting

**❌ 문제 상황**
<br/>
국립중앙도서관 API에서 제공하는 책 이미지 데이터가 부족하여, 책 이미지 범위가 제한되는 문제가 발생

**⭕️ 해결 방법**
- 국립중앙도서관 API에서 책 정보를 검색할 때 ISBN 정보만 추출
- 추출한 ISBN 정보를 알라딘 API에서 재검색
- 이를 통해 책 제목, 저자, 이미지 등 풍부한 정보로 인해 검색 결과 구현 

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
뷰에 보여지는 날짜와 클릭한 날짜가 같을 경우 네트워크 중복 호출이 발생하는 문제

**⭕️ 해결 방법**
<br/>
`didSelect`와 `shouldSelect` 메소드를 활용하여 문제 해결
- `didSelect`: 날짜가 선택될 때 선택된 날짜를 저장
- `shouldSelect`: 다른 날짜를 선택할 때 기존 날짜를 초기화하고, 같은 날짜를 선택할 경우 선택 방지

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
- [ ]  Launch Screen 설정
- [ ]  본인 생일 입력 → Push Notification
- [ ]  Realm PK Key 수정
- [ ]  adult 연령의 책 제한

<br/>

## 👏🏻 회고

프로젝트를 시작하기 전 API 사전 조사의 중요성을 깨달았다. 날짜를 기준으로 책 정보를 검색할 수 있는 API는 국립중앙도서관이 유일했기 때문에 이를 통해 프로젝트를 시작했다. 하지만 국립중앙도서관 API를 사용하면서 책 이미지 데이터의 부족함을 느꼈고, 이로 인해 사용자에게 보여줄 수 있는 책 이미지 범위가 제한되는 문제를 직면했다. 국립중앙도서관 API에서 제공하는 책 정보 중 책 이미지 URL을 포함하고 있는 데이터가 많지 않았기 때문이다. 이로 인해 이미지가 있는 책들만 배열에 넣고 보여주는 방식으로 진행했지만 검색화면(SearchView)을 구현하는 과정 중에 데이터의 양이 크게 제한되는 결과를 초래했다.

국립중앙도서관 API의 한계를 극복하기 위해, 날짜를 클릭 시 국립중앙도서관 API에서 ISBN만을 추출하여 이를 알라딘 API에서 재검색하는 방식으로 전환했고, 알라딘 API로 책 제목, 저자, 이미지 등 풍부한 정보로 인해 더 만족스러운 검색 결과를 구현할 수 있었다. 



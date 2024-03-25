# 📚생일책

![App Icon_125](https://github.com/jieun0330/BirthdayBook/assets/42729069/af8ce70f-008c-4c14-8c13-442353237895)

2024.03.07 ~

내 생일에, 내가 사랑하는 사람의 생일에는 어떤 책이 태어났을까요?

나와 생일이 같은 책들을 확인하고, 특별하고 의미있는 생일을 책으로 축하해줄 수 있습니다

|![Frame 517167433](https://github.com/jieun0330/BirthdayBook/assets/42729069/f1aa4c40-57d9-404e-94e1-90496e3e8b0a)|![Frame 517167434](https://github.com/jieun0330/BirthdayBook/assets/42729069/de7db9b7-dd95-4334-bf4a-86e53624e171)|![Frame 517167437](https://github.com/jieun0330/BirthdayBook/assets/42729069/863875f1-2efe-4e0a-b8b6-a5fd29d420b5)
|---|---|---|

<br/>


### ⚒️ Skills

`MVVM` `SnapKit` `Realm` `Alamofire` `FSCalendar` `Kingfisher`

<br/>

### Trouble Shooting 1️⃣ 국립중앙도서관, 알라딘 API 연쇄 호출

특정 날짜에 발행된 책들을 검색하기 위해 국립중앙도서관 API를 사용했다. 책의 ISBN 번호를 이용해 추가 정보(제목, 저자 등)를 얻기 위해 알라딘 API의 추가 검색이 필요했다.

<aside>
📚 국립중앙도서관 API 호출 → 책의 ISBN 번호 전달 📚 알라딘 API 호출
</aside>

![image](https://github.com/jieun0330/BirthdayBook/assets/42729069/088ccce8-ffa6-484d-a533-e2989e1b5580)

처음에는 이 두 단계를 연속적으로 실행하게되는 단순하고 직관적인 아도겐 형태의 코드로 구현했다.

![image](https://github.com/jieun0330/BirthdayBook/assets/42729069/40f6100f-2582-4df0-abcd-832d15384f16)

이 과정에 전환한 점은 첫번째 동작에서 얻은 ISBN 번호를 두번째 동작의 Trigger로 활용하는 구조로 변경한 것이다. 이렇게 하니, 각 단계에서 어떤 데이터를 처리하고 어떻게 다음 단계로 넘기는지가 명확해졌다. 또한, 코드의 가독성도 크게 향상되었다.

<br/>

### Trouble Shooting 2️⃣ Realm 데이터 참조 및 삭제 문제

![image](https://github.com/jieun0330/BirthdayBook/assets/42729069/45c6af34-9032-4be2-9193-a8d8e1f5b662)
한 화면 내에서 북마크의 저장 및 삭제 기능을 구현할때, 런타임 오류를 만났다. ‘삭제된 레코드를 어디선가 참조’하는 상황이 발생해서 이를 해결하는 과정이 내겐 매우 중요했다. Realm 데이터베이스를 사용하면서 Realm의 참조 특성에 대한 이해가 부족했던 탓이다. 삭제된 객체가 다른 객체와 관계가 있는 경우, 참조만 삭제되어 문제가 발생할 수 있었던 것이다.

![image](https://github.com/jieun0330/BirthdayBook/assets/42729069/3431a4b3-c0e2-457d-b6fe-41d60166cb66)

Realm 형식으로 받아온 데이터 구조를 Item 형식으로 변환하여 문제를 해결했다. 데이터 참조 문제를 우회해서 해결할 수 있었지만 현재 해결책은 임시적이여서, 리팩토링이 꼭 필요한 부분이다.

<br/>

### Trouble Shooting 3️⃣ API 결과물과 Realm 저장 결과물 통합

![image](https://github.com/jieun0330/BirthdayBook/assets/42729069/295f961e-a2f4-4d85-b2e7-f16d661eb7dc)

![image](https://github.com/jieun0330/BirthdayBook/assets/42729069/c4c24b4a-272c-4358-8bc5-529a0bec32d3)

API로부터 받은 데이터를 보여주는 DetailView와, 같은 데이터를 Realm에 저장한 후 보여주는 BookmarkView 화면을 동일하게 구현하는 과정이였다. 처음에는 오버로드를 사용하여 구현했지만, 코드 중복 문제를 해결하기 위해 제네릭으로 전환했다. 이 과정에서 DTO라는 개념을 접하게 되었고, 이를 공부해서 업데이트에 적용해봐야겠다.

<br/>

### Post Mortem

### 아쉬웠던 점

프로젝트를 시작하기 전 API 사전 조사의 중요성을 깨달았다. 날짜를 기준으로 책 정보를 검색할 수 있는 API는 국립중앙도서관이 유일했기 때문에 이를 통해 프로젝트를 시작했다. 하지만 국립중앙도서관 API를 사용하면서 책 이미지 데이터의 부족함을 느꼈고, 이로 인해 사용자에게 보여줄 수 있는 책 이미지 범위가 제한되는 문제를 직면했다. 국립중앙도서관 API에서 제공하는 책 정보 중 책 이미지 URL을 포함하고 있는 데이터가 많지 않았기 때문이다. 이로 인해 이미지가 있는 책들만 배열에 넣고 보여주는 방식으로 진행했지만 검색화면(SearchView)을 구현하는 과정 중에 데이터의 양이 크게 제한되는 결과를 초래했다.

국립중앙도서관 API의 한계를 극복하기 위해, 날짜를 클릭 시 국립중앙도서관 API에서 ISBN만을 추출하여 이를 알라딘 API에서 재검색하는 방식으로 전환했고, 알라딘 API로 책 제목, 저자, 이미지 등 풍부한 정보로 인해 더 만족스러운 검색 결과를 구현할 수 있었다. API에 대해 정보를 더 갖고있었다면 시간이 단축될 수 있을거라고 생각한다.

### 업데이트 사항

- [ ]  Realm Notification Token
- [ ]  Network 상태코드별 에러 핸들링
- [ ]  DTO
- [ ]  메모리 누수 확인
- [ ]  런치스크린
- [ ]  CollectionView Compositional Layout
- [ ]  본인 생일 입력 → Push Notification
- [ ]  Realm 저장 요소를 PK 하나로 수정

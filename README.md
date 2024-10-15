## 마이미디어

+ 프로젝트 기간: 2024.10.08 ~ 2024.10.12 
+ 3인 개발
  
|김연정|권대윤|전준영|
|:---:|:---:|:---:|
|[Daeyun](https://github.com/daeyunkwon)|[Joy](https://github.com/JoyKim-Dev)|[Ethan](https://github.com/Junyeong-J)|
|DB 구축, 홈화면 구현|네트워크 구축, 보관화면 구현, 상세화면 구현|초기설정, 검색화면 구현|

### Introduction

+ 미디어를 탐색하고 보관함에 저장할 수 있는 앱
+ Configuration: iOS 15.0 +

### Features

 #### * 홈 화면
  
+ 최신 트렌드 영화와 티비 시리즈 중 랜덤한 미디어를 메인 포스터에 띄워 추천해줍니다.
  
+ 최신 트렌드 영화와 티비 시리즈 리스트를 하단에 보여줍니다. 
  
+ 내가 찜한 리스트 버튼을 눌러서 보관함에 추가합니다. 

+ 미디어 포스터를 누르면 상세 화면으로 전환됩니다. 

#### * 검색 화면 

+ 별도 검색어가 없을 때는 최신 트렌드 영화 리스트를 보여줍니다.

+ 검색창에 원하는 영화나 티비 시리즈 제목을 기입하여 검색 가능합니다.

+ 모든 미디어를 실시간으로 검색할 수 있습니다.
  
+ 검색 결과가 많은 경우 세로 스크롤을 통해 추가 미디어 정보를 조회할 수 있습니다.

+ 검색 결과를 누르면 상세 화면으로 전환됩니다. 

#### * 보관 화면

+ 내가 찜한 미디어를 조회할 수 있습니다.

+ 내가 찜한 미디어를 왼쪽으로 밀어서 삭제할 수 있습니다.

+ 미디어를 선택하면 상세 화면으로 전환됩니다.

#### * 상세 화면

+ 선택한 미디어의 스틸컷, 평점, 줄거리, 출연진, 감독 등의 상세 정보를 보여줍니다. 

+ 저장 버튼을 누르면 보관함에 추가됩니다. 

+ 선택한 미디어와 비슷한 미디어 목록을 보여줍니다. 

### Technology Stack 
+ Framework : UIKit
+ Pattern : MVVM, Alamofire/Router 패턴
+ Library: RealmSwift, RxSwift, Alamofire, Kingfisher, SnapKit  

### Troubleshooting

#### * 문제 상황
+ UIButton의 글자색이 흰색 외 색상으로 변경되지 않는 문제가 발생했습니다.
  
#### * 원인 분석
+ AppDelegate에서 UILabel의 글자색을 흰색으로 전역 설정한 결과 UILabel을 상속받는 UIButton의 title 색상도 흰색으로 고정되는 것이 원인이었습니다.
  
#### * 해결 방안
+ UIButton 초기화 시점에 원하는 색상을 다시 한번 명시하여 해결했습니다.

### 회고

+ 프로젝트 기간동안 코어 코딩 시간대를 정해두고 임한 덕분에 매끄럽게 실시간 소통을 하며 개발할 수 있었습니다.

+ 팀원이 도움을 필요로 할 때 각자 맡은 역할을 넘어 집단 지성을 발휘하여 협력했기에 문제 해결을 할 수 있었습니다.

<!--
+ 공수산정 / 기술적으로 보완할 부분에 대한 내용 추가 / 브랜치를 어떤 단위로 나누는 것이 효율적인 것인가에 대한 생각
-->

+ 뷰와 기능의 연관성을 고려하여 프로젝트 역할 분담을 했으면 개발 시간을 단축할 수 있었을 것 같습니다. (예시: Realm 모델 구축 - 보관함 뷰 구현)
  
+ APIKey를 .gitignore 파일에 추가하여 git 추적을 방지했지만, APIKey 파일을 프로젝트에 포함한 상태로 github에 추가를 해서 pull 할 때마다 pbx conflict가 발생한 점이 아쉬웠습니다.  

### Screenshots

| 홈 화면 | 홈 화면 |
|---------------|---------------|
| <img src="https://github.com/user-attachments/assets/1823cdb1-c7b9-43bc-a85e-13715930bce9" width="250"> | <img src="https://github.com/user-attachments/assets/bc5f830b-7105-4d3b-beff-0362a4482b5e" width="250"> |

| 검색 화면 | 검색 화면 |
|---------------|---------------|
| <img src="https://github.com/user-attachments/assets/a4cd76ab-94ef-4f0c-a300-708fefeeb039" width="250"> | <img src="https://github.com/user-attachments/assets/07ea6760-a7c7-4c75-8d34-2ff4d6be946a" width="250"> |

| 보관 화면 | 상세 화면 |
|---------------|---------------|
| <img src="https://github.com/user-attachments/assets/1304ecc6-0b6f-41a2-810e-b92df95e370c" width="250"> | <img src="https://github.com/user-attachments/assets/cd8ec95e-b529-4363-95f7-e47e28b6c62e" width="250"> |



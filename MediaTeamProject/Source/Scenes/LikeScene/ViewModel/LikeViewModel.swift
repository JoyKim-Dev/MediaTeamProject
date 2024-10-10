//
//  LikeViewModel.swift
//  MediaTeamProject
//
//  Created by 권대윤 on 10/10/24.
//

import Foundation
import RxSwift

final class LikeViewModel: BaseViewModel {
    
    private var mediaList: [Media] = []
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let fetchData: PublishSubject<Void>
        let swipeDeleteButtonTapped: PublishSubject<Int>
    }
    
    struct Output {
        let mediaList: PublishSubject<[MySection]>
        let succeedDelete: PublishSubject<Int>
    }
    
    func transform(input: Input) -> Output {
        
        let mediaList = PublishSubject<[MySection]>()
        let succeedDelete = PublishSubject<Int>()
        
        input.fetchData
            .bind(with: self) { owner, _ in
                owner.mediaList = LikeViewModel.mockData
                mediaList.onNext([MySection(header: "First section", items: owner.mediaList)])
            }
            .disposed(by: disposeBag)
        
        input.swipeDeleteButtonTapped
            .bind(with: self) { owner, row in
                owner.mediaList.remove(at: row)
                mediaList.onNext([MySection(header: "First section", items: owner.mediaList)])
            }
            .disposed(by: disposeBag)
        
        
        
        
        
        
        
        
        
        return Output(
            mediaList: mediaList,
            succeedDelete: succeedDelete
        )
    }
}

extension LikeViewModel {
    static let mockData = [MediaTeamProject.Media(id: 917496, name: nil, title: Optional("비틀쥬스 비틀쥬스"), overview: Optional("유령과 대화하는 영매로 유명세를 타게 된 리디아와 그런 엄마가 마음에 들지 않는 10대 딸 아스트리드. 할아버지 찰스의 갑작스러운 죽음으로 가족들은 함께 시골 마을에 내려간다. 유령을 보는 엄마가 마음에 들지 않는 아스트리드는 방황하던 중 함정에 빠져 저세상에 발을 들이게 되고 딸을 구하기 위해 리디아는 인간을 믿지 않는 저세상 슈퍼스타 비틀쥬스를 소환한다. 이루지 못한 리디아와의 결혼을 조건으로 내민 비틀쥬스. 이번엔 아스트리드가 비틀쥬스를 다시 저세상으로 보내야 하는데···"), poster_path: Optional("/ypWQatJYyESE5PIzdlSdiOyWYja.jpg"), backdrop_path: Optional("/xi1VSt3DtkevUmzCx2mNlCoDe74.jpg"), genre_ids: [35, 14, 27], vote_average: 7.2, media_type: Optional("movie")), MediaTeamProject.Media(id: 1087822, name: nil, title: Optional("헬보이: 더 크룩드 맨"), overview: Optional("Hellboy and a rookie BPRD agent get stranded in 1950s rural Appalachia. There, they discover a small community haunted by witches, led by a local devil with a troubling connection to Hellboy\'s past: the Crooked Man."), poster_path: Optional("/iz2GabtToVB05gLTVSH7ZvFtsMM.jpg"), backdrop_path: Optional("/78CquSA0GN0m7NIYnNECx91KFkJ.jpg"), genre_ids: [14, 27, 28, 12], vote_average: 4.5, media_type: Optional("movie")), MediaTeamProject.Media(id: 1186532, name: nil, title: Optional("The Forge"), overview: Optional("19 year old Isaiah Wright lives for basketball and video games. A year out of high school, he has no job, no plans, and no idea how to be a man. At odds with his single mother Cynthia, Isaiah is given an ultimatum – to step up or move out. Feeling the pull from his friends and the push from his mom, Isaiah is hired by Moore Fitness, unaware of how the owner will personally impact his life. With the prayers of his mother and unexpected guidance from his new mentor, Isaiah is forced to deal with his past, sacrifice his selfishness and discover how God might have a greater purpose for his life."), poster_path: Optional("/vXW1I7HGZkeGUqw8QpGFiDA31Ih.jpg"), backdrop_path: Optional("/m25DNsLhsODTp0QhKIur4vIby8C.jpg"), genre_ids: [18, 10751], vote_average: 6.3, media_type: Optional("movie")), MediaTeamProject.Media(id: 889737, name: nil, title: Optional("조커: 폴리 아 되"), overview: Optional("2년 전, 세상을 뒤흔들며 고담시 아이콘으로 자리한 아서 플렉은 아캄 수용소에 갇혀 최종 재판을 앞둔 무기력한 삶을 살아간다. 그러던 어느 날, 수용소에서 운명적으로 만난 리 퀸젤은 아서의 삶을 다시 뒤바꾸며 그의 마음 속에 잠들어 있던 조커를 깨우고 리 역시 각성하며 자신을 할리 퀸이라 지칭하며 서로에게 깊이 빠져든다. 무고한 시민을 죽인 죄로 재판에 오르게 된 아서. 그는 최후의 심판대에서 할리 퀸과 함께 자신, 조커의 이야기를 시작하는데…"), poster_path: Optional("/dA1TGJPTVjlqPc8PiEE2PfvFBUp.jpg"), backdrop_path: Optional("/reNf6GBzOe48l9WEnFOxXgW56Vg.jpg"), genre_ids: [18, 80, 53], vote_average: 5.8, media_type: Optional("movie")), MediaTeamProject.Media(id: 533535, name: nil, title: Optional("데드풀과 울버린"), overview: Optional("히어로 생활에서 은퇴한 후, 평범한 중고차 딜러로 살아가던 ‘데드풀’이 예상치 못한 거대한 위기를 맞아 모든 면에서 상극인 ‘울버린’을 찾아가게 되며 펼쳐지는 도파민 폭발 액션 블록버스터."), poster_path: Optional("/4Zb4Z2HjX1t5zr1qYOTdVoisJKp.jpg"), backdrop_path: Optional("/yDHYTfA3R0jFYba16jBB1ef8oIt.jpg"), genre_ids: [28, 35, 878], vote_average: 7.728, media_type: Optional("movie")), MediaTeamProject.Media(id: 1125510, name: nil, title: Optional("더 플랫폼 2"), overview: Optional("수직 구조로 된 감방. 정체 모를 리더가 잔혹한 시스템에 자체적인 규범을 도입시키고, 이후 새로운 인물이 나타나 수상한 배급 방식에 대해 반기를 든다."), poster_path: Optional("/poELZsrROLJW28gc1V9nB1kJigq.jpg"), backdrop_path: Optional("/3m0j3hCS8kMAaP9El6Vy5Lqnyft.jpg"), genre_ids: [878, 53, 18, 27], vote_average: 5.748, media_type: Optional("movie")), MediaTeamProject.Media(id: 1184918, name: nil, title: Optional("와일드 로봇"), overview: Optional("우연한 사고로 거대한 야생에 불시착한 로봇 로즈는 주변 동물들의 행동을 배우며 낯선 환경 속에 적응해 가던 중, 사고로 세상에 홀로 남겨진 아기 기러기 브라이트빌의 보호자가 된다. 로즈는 입력되어 있지 않은 새로운 역할과 관계에 낯선 감정을 마주하고 겨울이 오기 전에 남쪽으로 떠나야 하는 브라이트빌을 위해 동물들의 도움을 받아 이주를 위한 생존 기술을 가르쳐준다. 그러나 선천적으로 몸집이 작은 브라이트빌은 짧은 비행도 힘겨워 하는데..."), poster_path: Optional("/8dkuf9IuVh0VZjDTk7kAY67lU0U.jpg"), backdrop_path: Optional("/4zlOPT9CrtIX05bBIkYxNZsm5zN.jpg"), genre_ids: [16, 878, 10751], vote_average: 7.963, media_type: Optional("movie")), MediaTeamProject.Media(id: 4011, name: nil, title: Optional("비틀쥬스"), overview: Optional("신혼부부 아담과 바바라는 어처구니 없는 사고로 사망하고 행복했던 시절을 잊지 못해 유령이 되어 계속 집에 머문다. 그러던 어느날 찰스 가족이 이사오자 아담과 바바라는 그들을 쫓아낼 계획을 세운다. 찰스 가족을 쫓아내기 위해 유령소동을 벌였지만 번번이 실패한다. 아담부부는 찰스의 딸 리디아와 친해지고 리디아와 결혼을 꿈꾸는 사악한 장난꾸러기 비틀쥬스는 계속해서 사건을 벌이고, 일은 꼬여만 가는데..."), poster_path: Optional("/nnl6OWkyPpuMm595hmAxNW3rZFn.jpg"), backdrop_path: Optional("/sIzZQdXY21sEks9lGkGuXzqdGSA.jpg"), genre_ids: [14, 35], vote_average: 7.377, media_type: Optional("movie")), MediaTeamProject.Media(id: 748230, name: nil, title: Optional("Salem\'s Lot"), overview: Optional("Author Ben Mears returns to his childhood home of Jerusalem\'s Lot only to discover his hometown is being preyed upon by a bloodthirsty vampire."), poster_path: Optional("/j7ncdqBVufydVzVtxmXu8Ago4ox.jpg"), backdrop_path: Optional("/jf1V00dZdNkVfEq7VPk8frrlELk.jpg"), genre_ids: [27, 9648], vote_average: 6.313, media_type: Optional("movie")), MediaTeamProject.Media(id: 1114513, name: nil, title: Optional("스픽 노 이블"), overview: Optional("휴양지에서 처음 만나 우연히 함께 휴가를 보내게 된 두 가족. 패트릭(제임스 맥어보이)은 자신의 집으로 루이스(맥켄지 데이비스)의 가족을 초대한다. 다시 만나 즐거운 시간을 보낼 것이라 예상한 것도 잠시, 거절할 수 없는 호의와 불편한 상황들이 계속되며 불길한 두려움을 느끼고 집에 돌아가려 하던 중 숨겨진 진실을 마주하게 되는데…"), poster_path: Optional("/mXGlp8K10JhiY5ZNY7zMldm2lss.jpg"), backdrop_path: Optional("/9R9Za5kybgl5AhuCNoK3gngaBdG.jpg"), genre_ids: [27, 53], vote_average: 7.326, media_type: Optional("movie")), MediaTeamProject.Media(id: 1052280, name: nil, title: Optional("왓츠 인사이드"), overview: Optional("결혼식 전야 파티에 모인 대학 동창들. 의문의 가방을 들고 나타난 깜짝 손님의 등장과 함께, 파티장은 순식간에 사이코 스릴러 같은 악몽의 현장으로 돌변한다."), poster_path: Optional("/hP4KuHMQBUbyundBNet3wV7RPY7.jpg"), backdrop_path: Optional("/3LVVSvAkQGbL5fvG4VM3GfMaZBe.jpg"), genre_ids: [35, 9648, 878, 53], vote_average: 6.4, media_type: Optional("movie")), MediaTeamProject.Media(id: 933260, name: nil, title: Optional("서브스턴스"), overview: Optional("더 나은 버전의 당신을 꿈꿔본 적 있나요? 당신의 인생을 바꿔줄 신제품 ‘서브스턴스’. ‘서브스턴스’는 또 다른 당신을 만들어냅니다. 새롭고, 젊고, 더 아름답고, 더 완벽한 당신을. 단 한가지 규칙, 당신의 시간을 공유하면 됩니다. 당신을 위한 일주일, 새로운 당신을 위한 일주일, 각각 7일간의 완벽한 밸런스. 쉽죠? 균형을 존중한다면… 무엇이 잘못될 수 있을까요?"), poster_path: Optional("/xSa67KtRbpvVUN3SDzQWk2Zs5Nm.jpg"), backdrop_path: Optional("/7h6TqPB3ESmjuVbxCxAeB1c9OB1.jpg"), genre_ids: [27, 18, 878], vote_average: 7.3, media_type: Optional("movie")), MediaTeamProject.Media(id: 1029235, name: nil, title: Optional("아즈라엘"), overview: Optional("종말이 일어난 지 여러 해가 지난 후, 말을 못 하는 광신도들로 구성된 종교 단체에서 탈출한 젊은 여성 아즈라엘을 추적하는 이야기. 무자비한 지도자들에게 붙잡혀 감금당한 아즈라엘은 주변 황야 깊은 곳에 숨어있는 고대의 악마를 달래기 위한 제물로 바쳐질 예정이었다. 그러나 그녀는 살기 위해 어떤 것도 주저하지 않는다. 그녀의 불타는 복수와 탈출을 위한 맹렬한 질주는 극적으로 치닫는다."), poster_path: Optional("/qpdFKDvJS7oLKTcBLXOaMwUESbs.jpg"), backdrop_path: Optional("/6n8x85cljOfJkUvPDc7tTmGPv7F.jpg"), genre_ids: [28, 27, 53], vote_average: 5.6, media_type: Optional("movie")), MediaTeamProject.Media(id: 1190868, name: nil, title: Optional("V/H/S/Beyond"), overview: Optional("The infinite playground of forbidden worlds and dangerous lifeforms offered by the sci-fi horror genre will lead to the biggest, maddest, bloodiest V/H/S ever."), poster_path: Optional("/wXaf6VGNHIGU7qivapGOF7o4o4N.jpg"), backdrop_path: Optional("/kB7Eo8fjyHn4a80A2WUfW6YiMPG.jpg"), genre_ids: [27, 878, 53], vote_average: 6.8, media_type: Optional("movie")), MediaTeamProject.Media(id: 957452, name: nil, title: Optional("더 크로우"), overview: Optional("10월 30일 \'악마의 날\', 까마귀의 저주로 죽음에서 부활한 에릭(빌 스카스가드)의 잔인한 복수극을 담은 다크 히어로 액션물"), poster_path: Optional("/58QT4cPJ2u2TqWZkterDq9q4yxQ.jpg"), backdrop_path: Optional("/Asg2UUwipAdE87MxtJy7SQo08XI.jpg"), genre_ids: [28, 14, 27, 53, 80], vote_average: 5.6, media_type: Optional("movie")), MediaTeamProject.Media(id: 619264, name: nil, title: Optional("더 플랫폼"), overview: Optional("음식 한 상이 높은 층에서 아래층으로 내려오는 수직 구조의 시설. 위층 주민들의 배가 부를수록, 아래층 주민들은 굶주리는 절박한 신세가 된다. 이제 이곳에 반란의 기운이 드리우기 시작한다."), poster_path: Optional("/6K9ftJaj8wpaCGc6MUw8UNEwyw1.jpg"), backdrop_path: Optional("/3tkDMNfM2YuIAJlvGO6rfIzAnfG.jpg"), genre_ids: [18, 878, 53], vote_average: 6.985, media_type: Optional("movie")), MediaTeamProject.Media(id: 475557, name: nil, title: Optional("조커"), overview: Optional("홀어머니와 사는 아서 플렉은 코미디언을 꿈꾸지만 그의 삶은 좌절과 절망으로 가득 차 있다. 광대 아르바이트는 그에게 모욕을 가져다주기 일쑤고, 긴장하면 웃음을 통제할 수 없는 신경병 증세는 그를 더욱 고립시킨다. 정부 예산 긴축으로 인해 정신과 약물을 지원하던 공공의료 서비스마저 없어져 버린 어느 날, 아서는 지하철에서 시비를 걸어온 증권사 직원들에게 얻어맞던 와중에 동료가 건네준 권총으로 그들을 쏴 버리고 만다. 군중들은 지배계급에 대한 저항의 아이콘이 된 그를 추종하기 시작하며 광대 마스크로 얼굴을 가리고 거리로 쏟아져 나오기 시작하는데..."), poster_path: Optional("/wrCwH6WOvXQvVuqcKNUrLDCDxdw.jpg"), backdrop_path: Optional("/gZWl93sf8AxavYpVT1Un6EF3oCj.jpg"), genre_ids: [80, 53, 18], vote_average: 8.152, media_type: Optional("movie")), MediaTeamProject.Media(id: 1022789, name: nil, title: Optional("인사이드 아웃 2"), overview: Optional("13살이 된 라일리의 행복을 위해 매일 바쁘게 머릿속 감정 컨트롤 본부를 운영하는 ‘기쁨’, ‘슬픔’, ‘버럭’, ‘까칠’, ‘소심’. 그러던 어느 날, 낯선 감정인 ‘불안’, ‘당황’, ‘따분’, ‘부럽’이가 본부에 등장하고, 언제나 최악의 상황을 대비하며 제멋대로인 ‘불안’이와 기존 감정들은 계속 충돌한다. 결국 새로운 감정들에 의해 본부에서 쫓겨나게 된 기존 감정들은 다시 본부로 돌아가기 위해 위험천만한 모험을 시작하는데…"), poster_path: Optional("/x2BHx02jMbvpKjMvbf8XxJkYwHJ.jpg"), backdrop_path: Optional("/p5ozvmdgsmbWe0H8Xk7Rc8SCwAB.jpg"), genre_ids: [16, 10751, 12, 35, 18], vote_average: 7.629, media_type: Optional("movie")), MediaTeamProject.Media(id: 1034541, name: nil, title: Optional("테리파이어 3"), overview: Optional("Five years after surviving Art the Clown\'s Halloween massacre, Sienna and her brother are still struggling to rebuild their shattered lives. As the holiday season approaches, they try to embrace the Christmas spirit and leave the horrors of the past behind. But just when they think they\'re safe, Art returns, determined to turn their holiday cheer into a new nightmare. The festive season quickly unravels as Art unleashes his twisted brand of terror, proving that no holiday is safe."), poster_path: Optional("/7NDHoebflLwL1CcgLJ9wZbbDrmV.jpg"), backdrop_path: Optional("/xlkclSE4aq7r3JsFIJRgs21zUew.jpg"), genre_ids: [27, 53], vote_average: 6.563, media_type: Optional("movie")), MediaTeamProject.Media(id: 1360610, name: nil, title: Optional("메넨데즈 형제"), overview: Optional("부모를 살해한 죄로 무기징역을 선고받고 수감 중인 라일과 에릭 메넨데즈 형제가 직접 입을 열었다. 충격적인 범죄와 그 이후의 재판 과정을 다룬 다큐멘터리."), poster_path: Optional("/jladpsqJETD7Kh2QfFc4elsa5i0.jpg"), backdrop_path: Optional("/htEHcgW0vTK3d5jBwMjA7RADnTk.jpg"), genre_ids: [99, 80], vote_average: 7.325, media_type: Optional("movie"))]
}

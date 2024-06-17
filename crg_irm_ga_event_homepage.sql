
--master 테이블과 ga_homepage는 phone_number 값으로 비교
merge `maderi-cdp.crg_id_resolution.crg_id_resolution_master` as id_master
using (select DISTINCT ga_id, 'web' AS web from `maderi-cdp.crg_id_resolution.stg_ga_event_homepage`) as ga_homepage
on ga_homepage.ga_id=id_master.ga_id

-- crg_id_resolution_master와 ga_homepage 테이블 간 동일한 ga_id값이라면 ga_homepage내 web 태깅 값 추가
WHEN MATCHED THEN
UPDATE SET
id_master.ga_id=ga_homepage.ga_id,
id_master.web_ga=ga_homepage.web

-- crg_id_resolution_master와 ga_homepage 테이블 간 동일한 ga_id가 아니라면 라면 ga_homepage의 ga_id 값 행 추가
WHEN NOT MATCHED THEN 
INSERT (ga_id, web_ga, cust_id) VALUES(ga_homepage.ga_id,ga_homepage.web, GENERATE_UUID())
;

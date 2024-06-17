
--master 테이블과 ga_homepage는 phone_number 값으로 비교
merge `maderi-cdp.crg_id_resolution.crg_id_resolution_master` as id_master
using (select DISTINCT ga_id, 'mall' AS mall from `maderi-cdp.crg_id_resolution.stg_ga_event_mall`) as ga_mall
on ga_mall.ga_id=id_master.ga_id

-- crg_id_resolution_master와 ga_mall 테이블 간 동일한 ga_id라면 mall 태깅 값부여
WHEN MATCHED THEN
UPDATE SET
id_master.ga_id=ga_mall.ga_id ,
id_master.mall_ga=ga_mall.mall

-- crg_id_resolution_master와 ga_mall 테이블 간 동일한 ga_id가 아니라면 라면 ga_mall의 ga_id 값 행 추가
WHEN NOT MATCHED THEN 
INSERT (ga_id, mall_ga, cust_id) VALUES(ga_mall.ga_id,ga_mall.mall, GENERATE_UUID())
;

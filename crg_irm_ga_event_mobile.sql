
--master 테이블과 ga_homepage는 phone_number 값으로 비교
merge `maderi-cdp.crg_id_resolution.crg_id_resolution_master` as id_master
using (select DISTINCT ga_id, 'mobile' AS mobile, device_id from `maderi-cdp.crg_id_resolution.stg_ga_event_mobile`) as ga_mobile
on ga_mobile.ga_id=id_master.ga_id

-- crg_id_resolution_master와 ga_mobile 테이블 간 동일한 ga_id라면 mobile 태깅 값, device_id를 업데이트
WHEN MATCHED THEN
UPDATE SET
id_master.ga_id=ga_mobile.ga_id ,
id_master.mobile_ga=ga_mobile.mobile,
id_master.device_id=ga_mobile.device_id

-- crg_id_resolution_master와 ga_mobile 테이블 간 동일한 ga_id가 아니라면 라면 ga_mobile의 ga_id 값 행 추가
WHEN NOT MATCHED THEN 
INSERT (ga_id, mobile_ga,device_id, cust_id ) VALUES(ga_mobile.ga_id,ga_mobile.mobile, ga_mobile.device_id, GENERATE_UUID())
;
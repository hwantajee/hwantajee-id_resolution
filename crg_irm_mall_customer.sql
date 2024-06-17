
--master 테이블과 ga_homepage는 phone_number 값으로 비교
merge `maderi-cdp.crg_id_resolution.crg_id_resolution_master` as id_master
using (select DISTINCT ga_id, mall_user_id, phone_number from `maderi-cdp.crg_id_resolution.stg_crg_mall_customer`) as crg_mall_cust
on crg_mall_cust.ga_id=id_master.ga_id

-- crg_id_resolution_master와 crg_mall_cust 테이블 간 동일한 ga_id라면 ga_id, mall_user_id, phone_number를 업데이트
WHEN MATCHED THEN
UPDATE SET
id_master.ga_id=crg_mall_cust.ga_id ,
-- id_master.mobile_ga
-- id_master.web_ga
-- id_master.mall_ga
id_master.mall_user_id=crg_mall_cust.mall_user_id,
id_master.phone_number=crg_mall_cust.phone_number	
-- id_master.device_id

-- crg_id_resolution_master와 crg_mall_cust 테이블 간 동일한 ga_id가 아니라면라면  ga_id, mall_user_id, phone_number 값 행 추가
WHEN NOT MATCHED THEN 
INSERT (ga_id,mall_user_id,phone_number, cust_id) 
VALUES(crg_mall_cust.ga_id,crg_mall_cust.mall_user_id, crg_mall_cust.phone_number, GENERATE_UUID())
;
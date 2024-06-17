
--master 테이블과 ga_homepage는 phone_number 값으로 비교
merge `maderi-cdp.crg_id_resolution.crg_id_resolution_master` as id_master
using (select DISTINCT phone_number from `maderi-cdp.crg_id_resolution.stg_wellcafe_trial_customer`) as wc_t_cust
on wc_t_cust.phone_number=id_master.phone_number

-- id_resolution_main와 wc_t_cust(웰카페 체험 테이블) 테이블 간 동일한 phone_number라면  phone_number 값을 업데이트
WHEN MATCHED THEN
UPDATE SET
id_master.phone_number=wc_t_cust.phone_number

-- crg_id_resolution_master와 wc_t_cust(웰카페 체험 테이블) 테이블 간 동일한 phone_number가 아니라면라면  phone_number 값 행 추가
WHEN NOT MATCHED THEN 
INSERT (phone_number, cust_id) VALUES(wc_t_cust.phone_number,GENERATE_UUID())
;
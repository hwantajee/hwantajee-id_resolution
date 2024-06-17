--ga 모바일 행동데이터 내 master 값 ga_id, mobile_ga, device_id id 마스터 테이블에 추가
INSERT `maderi-cdp.crg_id_resolution.id_resolution_master_test_travis`  

(ga_id,mobile_ga,device_id)
 
  SELECT DISTINCT ga_id,mobile_ga,device_id FROM `maderi-cdp.crg_id_resolution.stg_ga_event_mobile` m group by ga_id,mobile_ga,device_id 
  Having m.ga_id not in (select ga_id from `maderi-cdp.crg_id_resolution.id_resolution_master_test_travis`);

--ga 모바일 행동데이터 내 master 값 ga_id,device_id id 마스터 테이블에 추가 (flag 값은 herick 코드로 붙여넣을 예정)
INSERT `maderi-cdp.crg_id_resolution.id_resolution_master_test_travis`  

(ga_id)
 
  SELECT DISTINCT ga_id FROM `maderi-cdp.crg_id_resolution.stg_ga_event_mall` m group by ga_id
  Having m.ga_id not in (select ga_id from `maderi-cdp.crg_id_resolution.id_resolution_master_test_travis`);


--ga homepage 해동데이터 내 master 값 ga_id값 마스터 테이블에 추가 (flag 값은 herick 코드로 붙여넣을 예정) 
INSERT `maderi-cdp.crg_id_resolution.id_resolution_master_test_travis`  

(ga_id)
 
  SELECT DISTINCT ga_id FROM `maderi-cdp.crg_id_resolution.stg_ga_event_homepage` m group by ga_id 
  Having m.ga_id not in (select ga_id from `maderi-cdp.crg_id_resolution.id_resolution_master_test_travis`);




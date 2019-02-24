require 'selenium-webdriver'
require 'net/http'
require 'uri'

driver = Selenium::WebDriver.for :firefox

driver.navigate.to 'https://class.admin.tus.ac.jp/up/faces/login/Com00505A.jsp'
driver.manage.timeouts.implicit_wait = 30

# ゲストユーザーボタンクリック
driver.find_element(:name, "form1:guest").click
# シラバス照会をクリック
driver.find_element(:id, "form1:htmlFlatMenuTable:1:text1").click
sleep 1
# 学期を選択
select = Selenium::WebDriver::Support::Select.new(driver.find_element(:id, 'form1:htmlGakkiNo'))
select.select_by(:value, '1')
sleep 1
# 学科組織を選択
select = Selenium::WebDriver::Support::Select.new(driver.find_element(:id, 'form1:htmlGakka'))
select.select_by(:value, '115')
sleep 1
# 検索ボタンをクリック
driver.find_element(:id, "form1:search").click
sleep 1
# 一番上のシラバスをクリック
driver.find_element(:id, "form1:htmlKekkatable:0:htmlKamokuNameCol").click
sleep 1

# Title取得
puts driver.find_element(:xpath, '//*[@id="form1"]/table/tbody/tr[1]/td[2]/table/tbody/tr[2]/td/div/table/tbody/tr/td/table/tbody/tr[2]/td').text
# Instructor取得
puts driver.find_element(:xpath, '//*[@id="form1"]/table/tbody/tr[1]/td[2]/table/tbody/tr[2]/td/div/table/tbody/tr/td/table/tbody/tr[5]/td').text
# week,koma取得
puts driver.find_element(:xpath, '//*[@id="form1"]/table/tbody/tr[1]/td[2]/table/tbody/tr[2]/td/div/table/tbody/tr/td/table/tbody/tr[7]/td').text
# Credit取得
puts driver.find_element(:xpath, '//*[@id="form1"]/table/tbody/tr[1]/td[2]/table/tbody/tr[2]/td/div/table/tbody/tr/td/table/tbody/tr[10]/td[1]').text
# Category取得
puts driver.find_element(:xpath, '//*[@id="form1"]/table/tbody/tr[1]/td[2]/table/tbody/tr[2]/td/div/table/tbody/tr/td/table/tbody/tr[11]/td[1]').text
# Elective取得
puts driver.find_element(:xpath, '//*[@id="form1"]/table/tbody/tr[1]/td[2]/table/tbody/tr[2]/td/div/table/tbody/tr/td/table/tbody/tr[11]/td[2]').text

sleep 5
driver.quit
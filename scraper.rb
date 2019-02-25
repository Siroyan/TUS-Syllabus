require 'selenium-webdriver'
require 'active_record'
require 'net/http'
require 'uri'


ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3',
    database: './syllabuses.db'
)

class Syllabus < ActiveRecord::Base
end


driver = Selenium::WebDriver.for :firefox

driver.navigate.to 'https://class.admin.tus.ac.jp/up/faces/login/Com00505A.jsp'
driver.manage.timeouts.implicit_wait = 30

# ゲストユーザーボタンクリック
driver.find_element(:name, "form1:guest").click
# シラバス照会をクリック
driver.find_element(:id, "form1:htmlFlatMenuTable:1:text1").click
sleep 0.5

# 学期を選択
select = Selenium::WebDriver::Support::Select.new(driver.find_element(:id, 'form1:htmlGakkiNo'))
select.select_by(:value, '1')
sleep 0.5

# 学科組織を選択
# 110 - 教養 111 - S, 112 - B, 113 - K, 114 - OS, 115 - OB, 116 - OK
# 140 - 教養 141 - A, 142 - C, 143 - E, 144 - I, 145 - M, 146 - i
select = Selenium::WebDriver::Support::Select.new(driver.find_element(:id, 'form1:htmlGakka'))
select.select_by(:value, '114')
sleep 0.5

# 検索ボタンをクリック
driver.find_element(:id, "form1:search").click
sleep 0.5


for page in 0..12 do
    for num in 0..17 do
        if (num + 18 * page) > 232 then
            puts 'Scraping Complete!'
            driver.quit
        end
        # 一番上のシラバスをクリック
        driver.find_element(:id, "form1:htmlKekkatable:#{num + 18 * page}:htmlKamokuNameCol").click
        sleep 0.5

        # Title取得
        title = driver.find_element(:xpath, '//*[@id="form1"]/table/tbody/tr[1]/td[2]/table/tbody/tr[2]/td/div/table/tbody/tr/td/table/tbody/tr[2]/td').text
        # Instructor取得
        instructor = driver.find_element(:xpath, '//*[@id="form1"]/table/tbody/tr[1]/td[2]/table/tbody/tr[2]/td/div/table/tbody/tr/td/table/tbody/tr[5]/td').text
        # week,koma取得
        zigen = driver.find_element(:xpath, '//*[@id="form1"]/table/tbody/tr[1]/td[2]/table/tbody/tr[2]/td/div/table/tbody/tr/td/table/tbody/tr[7]/td').text
        # Credit取得
        credit = driver.find_element(:xpath, '//*[@id="form1"]/table/tbody/tr[1]/td[2]/table/tbody/tr[2]/td/div/table/tbody/tr/td/table/tbody/tr[10]/td[1]').text
        # Category取得
        category = driver.find_element(:xpath, '//*[@id="form1"]/table/tbody/tr[1]/td[2]/table/tbody/tr[2]/td/div/table/tbody/tr/td/table/tbody/tr[11]/td[1]').text
        # Elective取得
        elective = driver.find_element(:xpath, '//*[@id="form1"]/table/tbody/tr[1]/td[2]/table/tbody/tr[2]/td/div/table/tbody/tr/td/table/tbody/tr[11]/td[2]').text

        # 戻るボタンをクリック
        driver.find_element(:id, "form1:back00").click

        syllabus = Syllabus.new
        syllabus.title = title
        syllabus.instructor = instructor
        syllabus.gakubu = '理学部'
        syllabus.gakka = 'OS'
        syllabus.week = zigen.chars[0]
        syllabus.koma = zigen.chars[2]
        syllabus.credit = credit
        syllabus.category = category
        syllabus.elective = elective

        syllabus.save

        puts "Syllabus : #{num + 18 * page}"
        sleep 0.5
    end
    # 次のページボタンをクリック
    driver.find_element(:id, "form1:htmlKekkatable:deluxe1__pagerNext").click
    sleep 0.5
end
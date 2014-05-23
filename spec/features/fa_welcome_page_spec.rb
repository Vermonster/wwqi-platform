# Encoding: utf-8
require 'spec_helper'

feature 'Persian Welcome page in Persian' do
  before { visit root_path(locale: 'fa') }

  scenario 'shows welcome header' do
    expect(page).to have_content('به «پژوهشگاه دنیای زنان در عصر قاجار» خوش آمدی')
    expect(page).not_to have_content('Welcome to the WWQI Research Platform')
  end

  scenario 'shows welcome description' do
    expect(page).to have_content('به پژوهشگاه «دنیای زنان در عصر قاجار» خوش آمدید. هدف این پژوهشگاه ایجاد فضایی برای گفتگو و تبادل فکری میان دانشجویان و پژوهشگرانی است که علاقه دارند با استفاده از منابع دیجیتال این آرشیو پژوهشهای خلاق در زمینه تاریخ فرهنگی دوره قاجار را، با تمرکز بر زندگی زنان و مقولات جنس‌گونگی و جنسیت، گسترش دهند')
  end

  scenario 'shows feature header' do
    expect(page).to have_content(':امکاناتی که این پژوهشگاه فراهم می آورد')
  end

  scenario 'shows Question & Discussion header' do
    expect(page).to have_content('پرسش و گفتگو')
  end

  scenario 'shows Qusetion & Discussion description' do
    expect(page).to have_content('می توانید با طرح سؤال یا نکته ای رشته گفتگو و بحث را آغاز کنید، در رشته گفتگوهای دیگران شرکت کنید، پرسش ها و نکات را به اقلام سایت «دنیای زنان در عصر قاجار» پیوند دهید، و بسیار امکانات دیگر')
  end

  scenario 'shows Research in Progress header' do
    expect(page).to have_content('پژوهشهای در جریان')
  end

  scenario 'shows Research in Progress description' do
    expect(page).to have_content('می توانید کارهای پژوهشی، یادداشت ها و ایده های تحقیقی خود را برای مبادله فکری با دیگران به اشتراک بگذارید؛ و یا با نقد و نظر خود به پژوهشهای دیگران یاری رسانید')
  end

  scenario 'shows Contribution header' do
    expect(page).to have_content('مشارکت')
  end

  scenario 'shows Contribution description' do
    expect(page).to have_content('می توانید به انواع مختلف با«دنیای زنان در عصر قاجار» همکاری کنید؛ از جمله ترجمه اسناد، تایپ اسناد خطی، نگارش شرح حال افراد موجود در آرشیو، تکمیل زندگی نامه های موجود، و تصحیح اطلاعات مربوط به اقلام آرشیو')
  end

  scenario 'shows sign up header' do
    expect(page).to have_content(':برای استفاده از امکانات پژوهشگاه باید ابتدا در بخش سمت چپ ثبت نام کنید و از آن پس با وارد کردن نام کاربری و رمز ورود خود به پژوهشگاه وارد شوید')
  end

  scenario 'shows sign up' do
    # expect(page).to have_content('')
  end

  scenario 'shows sign up description' do
    expect(page).to have_content('اگر بار اولی است که وارد این پژوهشگاه می‌شوید، از اینجا شروع کنید. لطفا توجه کنید که نام، نام خانوادگی، و نام کاربری باید به حروف لاتین باشد. برای رمز ورود می توانید از حروف و اعداد لاتین استفاده کنی')
  end

  scenario 'shows sign in' do
    # expect(page).to have_content('')
  end

  scenario 'shows sign in description' do
    expect(page).to have_content(':اگر نام کاربری و رمز ورود دارید، از اینجا وارد شوید')
  end

  scenario 'shows a language swtich button' do
    expect(page).to have_link('English', href: root_path(locale: 'en'))
  end
end

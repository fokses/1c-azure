
#Область ОбработкаСобытийФормы
&НаКлиенте
Процедура ПутьКФайлуНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	
	Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Сохранение);
	Диалог.МножественныйВыбор = Ложь;
	
	ОП = Новый ОписаниеОповещения("ВыборФайлаЗавершение", ЭтотОбъект); 
	
	Диалог.Показать(ОП);
КонецПроцедуры

&НаКлиенте
Процедура ВыборФайлаЗавершение(ВыбранныеФайлы, ДопНастройки) Экспорт
	Если ВыбранныеФайлы <> Неопределено Тогда
		Объект.ПутьКФайлу = ВыбранныеФайлы[0];
	КонецЕсли; 			
КонецПроцедуры


#Область ОбработкаКомандФормы
&НаСервере
Функция ПолучитьФайлНаСервере()

	СтатусОтвет = AzureВызовСервера.ПолучитьФайлAzureFile(
		Объект.СтрокаПодключения,
		Объект.FileName,
		Объект.ShareName,
		Объект.DirectoryPath,
		Объект.ПроверитьMD5);
		
	Возврат СтатусОтвет;
КонецФункции

&НаКлиенте
Процедура ПолучитьФайлКлиент(Команда)
	СтатусОтвет = ПолучитьФайлНаСервере();
	ВспомогательныйКлиент.ВывестиСтатус(СтатусОтвет);
	
	Если НЕ СтатусОтвет.Отказ Тогда
		ДвДанныеПолученныйФайл = СтатусОтвет.Ответ.Тело;
		ДвДанныеПолученныйФайл.Записать(Объект.ПутьКФайлу);
	КонецЕсли; 
КонецПроцедуры
#КонецОбласти 

#КонецОбласти 

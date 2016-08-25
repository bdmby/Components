//*****************************************************************************
//**  LangMan -  Localization components package for Delphi                  **
//*****************************************************************************
//**                                                                         **
//**  File:      LangManISO.pas                                              **
//**                                                                         **
//**  Version:   2.6.6                                                       **
//**                                                                         **
//**  Date:      2016-05-11                                                  **
//**                                                                         **
//**  Author:    Ing. Tomas Halabala - REGULACE.ORG                          **
//**                                                                         **
//**  Notice:    This components set is free for personal use only.          **
//**             Comercial use is not allowed without author permission!     **
//**                                                                         **
//**             It is not permitted to use these components in application  **
//**             published under a different publisher name than what is     **
//**             registered with this copy. Transferring the license to      **
//**             another person or company is not possible.                  **
//**                                                                         **
//**             It is prohibited the distribution of any part or whole      **
//**             source code and use part or whole source code for           **
//**             the creation and distribution of any other component,       **
//**             distributed with or without source code.                    **
//**                                                                         **
//**  Licensee:  DZMITRY BRIKHANCHYK                                         **
//**                                                                         **
//**  Disclaimer:THIS SOFTWARE AND ANY RELATED DOCUMENTATION IS PROVIDED     **
//**             "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED      **
//**             OR IMPLIED INCLUDING BUT NOT LIMITED TO THE APPLIED         **
//**             WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR     **
//**             PURPOSE, OR NONINFRINGEMENT. AUTHOR DOES NOT WARRANT,       **
//**             GUARANTEE, OR MAKE ANY REPRESENTATIONS REGARDING THE USE,   **
//**             OR THE RESULTS OF THE USE, OF THE SOFTWARE IN TERMS OF      **
//**             CORRECTNESS, ACCURACY, RELIABILITY, OR OTHERWISE.           **
//**             THE ENTIRE RISK ARISING OUT OF USE OR PERFORMANCE           **
//**             OF THE SOFTWARE REMAINS WITH YOU.                           **
//**                                                                         **
//**  Copyright: Copyright (c) 2009-2016 Ing.Tomas Halabala                  **
//**                                                                         **
//**  E-mail:    tomas.halabala@regulace.org                                 **
//**                                                                         **
//**  Website:   http://www.regulace.org                                     **
//**                                                                         **
//*****************************************************************************

unit LangManISO;

interface

const ISO_CODES_COUNT = 186;
      RTL_LANGS_COUNT = 7;
      UNDEFINED_LANG_CODE = 'xx';
      LANG_ISO_NAME_SEPARATOR = '-';
      RTL_LANGS: array[0..RTL_LANGS_COUNT-1] of String = ('ar', 'he', 'ps', 'sd', 'tt', 'ur', 'yi');
      ISO_639_1: array[0..ISO_CODES_COUNT-1] of String = ('ab - Abkhazian',
                                                        'aa - Afar',
                                                        'af - Afrikaans',
                                                        'ak - Akan',
                                                        'sq - Albanian',
                                                        'am - Amharic',
                                                        'ar - Arabic',
                                                        'an - Aragonese',
                                                        'hy - Armenian',
                                                        'as - Assamese',
                                                        'av - Avaric',
                                                        'ae - Avestan',
                                                        'ay - Aymara',
                                                        'az - Azerbaijani',
                                                        'bm - Bambara',
                                                        'ba - Bashkir',
                                                        'eu - Basque',
                                                        'be - Belarusian',
                                                        'bn - Bengali',
                                                        'bh - Bihari languages',
                                                        'bi - Bislama',
                                                        'bs - Bosnian',
                                                        'br - Breton',
                                                        'bg - Bulgarian',
                                                        'my - Burmese',
                                                        'ca - Catalan',
                                                        'km - Central Khmer',
                                                        'ch - Chamorro',
                                                        'ce - Chechen',
                                                        'ny - Chewa',
                                                        'zh - Chinese',
                                                        'cu - Church Slavic',
                                                        'cv - Chuvash',
                                                        'kw - Cornish',
                                                        'co - Corsican',
                                                        'cr - Cree',
                                                        'hr - Croatian',
                                                        'cs - Czech',
                                                        'da - Danish',
                                                        'dv - Dhivehi',
                                                        'nl - Dutch',
                                                        'dz - Dzongkha',
                                                        'en - English',
                                                        'eo - Esperanto',
                                                        'et - Estonian',
                                                        'ee - Ewe',
                                                        'fo - Faroese',
                                                        'fj - Fijian',
                                                        'fi - Finnish',
                                                        'fr - French',
                                                        'ff - Fulah',
                                                        'gl - Galician',
                                                        'lg - Ganda',
                                                        'gd - Gaelic',
                                                        'ka - Georgian',
                                                        'de - German',
                                                        'el - Greek',
                                                        'gn - Guarani',
                                                        'gu - Gujarati',
                                                        'ht - Haitian',
                                                        'ha - Hausa',
                                                        'he - Hebrew',
                                                        'hz - Herero',
                                                        'hi - Hindi',
                                                        'ho - Hiri Motu',
                                                        'hu - Hungarian',
                                                        'is - Icelandic',
                                                        'io - Ido',
                                                        'ig - Igbo',
                                                        'id - Indonesian',
                                                        'ia - Interlingua',
                                                        'ie - Interlingue',
                                                        'iu - Inuktitut',
                                                        'ik - Inupiaq',
                                                        'ga - Irish',
                                                        'it - Italian',
                                                        'ja - Japanese',
                                                        'jv - Javanese',
                                                        'kl - Kalaallisut',
                                                        'kn - Kannada',
                                                        'kr - Kanuri',
                                                        'ks - Kashmiri',
                                                        'kk - Kazakh',
                                                        'ki - Kikuyu',
                                                        'rw - Kinyarwanda',
                                                        'ky - Kirghiz',
                                                        'kv - Komi',
                                                        'kg - Kongo',
                                                        'ko - Korean',
                                                        'kj - Kuanyama',
                                                        'ku - Kurdish',
                                                        'lo - Lao',
                                                        'la - latin',
                                                        'lv - Latvian',
                                                        'li - Limburgish',
                                                        'ln - Lingala',
                                                        'lt - Lithuanian',
                                                        'lu - Luba-Katanga',
                                                        'lb - Luxembourgish',
                                                        'mk - Macedonian',
                                                        'mg - Malagasy',
                                                        'ms - Malay',
                                                        'ml - Malayalam',
                                                        'mt - Maltese',
                                                        'gv - Manx',
                                                        'mi - Maori',
                                                        'mr - Marathi',
                                                        'mh - Marshallese',
                                                        'mn - Mongolian',
                                                        'na - Nauru',
                                                        'nv - Navaho',
                                                        'nd - Ndebele, North',
                                                        'nr - Ndebele, South',
                                                        'ng - Ndonga',
                                                        'ne - Nepali',
                                                        'se - Northern Sami',
                                                        'no - Norwegian',
                                                        'nb - Norwegian Bokmål',
                                                        'nn - Norwegian Nynorsk',
                                                        'ny - Nyanja',
                                                        'oc - Occitan',
                                                        'oj - Ojibwa',
                                                        'or - Oriya',
                                                        'om - Oromo',
                                                        'os - Ossetian',
                                                        'pi - Pali',
                                                        'pa - Panjabi',
                                                        'ps - Pashto',
                                                        'fa - Persian',
                                                        'pl - Polish',
                                                        'pt - Portuguese',
                                                        'qu - Quechua',
                                                        'ro - Romanian, Moldavian',
                                                        'rm - Romansh',
                                                        'rn - Rundi',
                                                        'ru - Russian',
                                                        'sm - Samoan',
                                                        'sg - Sango',
                                                        'sa - Sanskrit',
                                                        'sc - Sardinian',
                                                        'sr - Serbian',
                                                        'sh - Serbo-Croatian',
                                                        'sn - Shona',
                                                        'ii - Sichuan Yi',
                                                        'sd - Sindhi',
                                                        'si - Sinhala',
                                                        'sk - Slovak',
                                                        'sl - Slovenian',
                                                        'so - Somali',
                                                        'st - Southern Sotho',
                                                        'es - Spanish',
                                                        'su - Sundanese',
                                                        'sw - Swahili',
                                                        'ss - Swati',
                                                        'sv - Swedish',
                                                        'tl - Tagalog',
                                                        'ty - Tahitian',
                                                        'tg - Tajik',
                                                        'ta - Tamil',
                                                        'tt - Tatar',
                                                        'te - Telugu',
                                                        'th - Thai',
                                                        'bo - Tibetan',
                                                        'ti - Tigrinya',
                                                        'to - Tonga',
                                                        'ts - Tsonga',
                                                        'tn - Tswana',
                                                        'tr - Turkish',
                                                        'tk - Turkmen',
                                                        'tw - Twi',
                                                        'ug - Uighur',
                                                        'uk - Ukrainian',
                                                        'ur - Urdu',
                                                        'uz - Uzbek',
                                                        've - Venda',
                                                        'vi - Vietnamese',
                                                        'vo - Volapük',
                                                        'wa - Walloon',
                                                        'cy - Welsh',
                                                        'fy - Western Frisian',
                                                        'wo - Wolof',
                                                        'xh - Xhosa',
                                                        'yi - Yiddish',
                                                        'yo - Yoruba',
                                                        'za - Zhuang',
                                                        'zu - Zulu');


function SeparateLangName(const ISOName: String): String;
function LangISOToEnglishName(const ISOCode: String): String;
function RTLLanguage(const ISOCode: String): Boolean;

implementation

uses SysUtils;

function SeparateLangName(const ISOName: String): String;
var SeparPos: Integer;
begin
{$IFDEF NEXTGEN}
  SeparPos := ISOName.IndexOf(LANG_ISO_NAME_SEPARATOR);
  if (SeparPos > 0) AND (SeparPos < High(ISOName)) then Result := Trim(ISOName.Substring(SeparPos+1))
                                                   else Result := '';
{$ELSE}
  SeparPos := Pos(LANG_ISO_NAME_SEPARATOR, ISOName);
  if (SeparPos > 1) AND (SeparPos < Length(ISOName))
    then Result := Trim(Copy(ISOName, SeparPos+1, Length(ISOName) - SeparPos))
    else Result := '';
{$ENDIF}
end;

function LangISOToEnglishName(const ISOCode: String): String;
var ici: Integer;
    iso1: String;
begin
  Result := '';
  if ISOCode <> '' then begin
{$IFDEF NEXTGEN}
    iso1 := ISOCode.ToLower.Trim;
{$ELSE}
    iso1 := LowerCase(Trim(ISOCode));
{$ENDIF}
    if Length(iso1) = 2 then begin // OK
      for ici := 0 to ISO_CODES_COUNT-1 do begin
{$IFDEF NEXTGEN}
        if (iso1[0] = ISO_639_1[ici][0]) AND (iso1[1] = ISO_639_1[ici][1]) then begin
{$ELSE}
        if (iso1[1] = ISO_639_1[ici][1]) AND (iso1[2] = ISO_639_1[ici][2]) then begin
{$ENDIF}
          Result := SeparateLangName(ISO_639_1[ici]);
          Exit;
        end;
      end;
    end;
  end;
end;

function RTLLanguage(const ISOCode: String): Boolean;
var ici: Integer;
    iso1: String;
begin
  Result := false;
  if ISOCode <> '' then begin
{$IFDEF NEXTGEN}
    iso1 := ISOCode.ToLower.Trim;
{$ELSE}
    iso1 := LowerCase(Trim(ISOCode));
{$ENDIF}
    if Length(iso1) >= 2 then begin // OK
      for ici := 0 to RTL_LANGS_COUNT-1 do begin
{$IFDEF NEXTGEN}
        if (iso1[0] = RTL_LANGS[ici][0]) AND (iso1[1] = RTL_LANGS[ici][1]) then begin
{$ELSE}
        if (iso1[1] = RTL_LANGS[ici][1]) AND (iso1[2] = RTL_LANGS[ici][2]) then begin
{$ENDIF}
          Result := true;
          Exit;
        end;
      end;
    end;
  end;
end;

end.

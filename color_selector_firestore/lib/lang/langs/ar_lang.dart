// ignore_for_file: annotate_overrides

import 'package:color_picker/lang/lang.dart';
import 'package:flutter/material.dart';

class Portuguese extends Language {
  String get code => 'ar';
  String get langName => 'Arabic';

  String get title => 'محدد الالوان';

  String get wheelPicker => 'عجلة';
  String get palettePicker => 'طبق';
  String get valuePicker => 'قيمة';
  String get namedPicker => 'أسم';
  String get imagePicker => 'صورة';

  String get red => 'اللون الاحمر (Red)';
  String get green => 'اللون الاخضر (Green)';
  String get blue => 'الازرق (Blue)';
  String get alpha => 'Alpha';

  String get hexCode => 'هكس كود';
  String get hex => 'هكس';
  String get cssHex => 'css كود';
  String get clear => 'امسح';
  String get hexCodeMustNotBeEmpty => 'هكس كود لا يجب ان يكون خالى';
  String get hexCodeLengthMustBeSix =>
      'هكس كود يجب ان يكون ستة عناصر';
  String get hexCodeLimitedChars =>
      'O código hexadecimal só pode ter caracteres de 0 a 9 e de A a F';
  String get hexCodeOpacity =>
      'Dica: a opacidade pode ser alterada pelo controle deslizante abaixo';

  String get hue => 'Matiz (Hue)';
  String get saturation => 'Saturação';
  String get lightness => 'Luminosidade';
  String get value => 'Valor';

  String get opacity => 'Opacidade';

  String get localImage => 'Imagem local';
  String get networkImage => 'Imagem da internet';
  String get selectPhoto => 'Selecionar imagem';

  String get favoriteColorsTitle => 'Cores favoritas';
  String get haventFavoritedAnyBefore =>
      'Você ainda não favoritou nenhuma cor!\nAperte ';
  String get haventFavoritedAnyAfter =>
      ' em uma previsualização de cor para favoritar';
  String get favorite => 'Favoritar';
  String get unfavorite => 'Desfavoritar';
  String get favorited => 'Favoritado';
  String get unfavorited => 'Desfavoritado';

  String get copyToClipboard => 'Copiar para a área de transferência';
  Widget copiedToClipboard(String text) {
    return RichText(
      text: TextSpan(text: '', children: [
        TextSpan(text: text, style: const TextStyle(color: Colors.blue)),
        const TextSpan(text: ' foi copiado para a área de transferência'),
      ]),
    );
  }

  String supportedPlatforms(List<TargetPlatform> platforms) {
    String text = 'Essa funcionalidade não está disponível no seu dispositivo';
    return text;
  }

  String get seeColorInfo => 'Ver informações da cor';
  String get colorInfo => 'Informações da cor';
  String colorWithOpacity(String name, int opacity) =>
      '$name com $opacity% de opacidade';

  String get settings => 'Configurações';
  String get user => 'Usuário';
  String get app => 'Aplicativo';
  String get initialColor => 'Cor inicial';
  String get language => 'Idioma';

  String get open => 'Abrir';
  String get close => 'Fechar';

  String get about => 'Sobre';
  String get author => 'Autor';
  String get openSource => 'Código-aberto';
  String get madeWithFlutter => 'Feito com Flutter 💙';

  String get theme => 'Tema do aplicativo';
  String get dark => 'Escuro';
  String get light => 'Claro';
  String get system => 'Sistema (padrão)';

  String minHeight(int height) =>
      'Esta funcionalidade só está disponível em dispositivos com uma tela maior que $height pixels';

  String get update => 'Atualizar';
  String get initialColorUpdated => 'Cor inicial atualizada';

  String get url => 'Url';
  String get urlMustNotBeEmpty => 'A url não pode estar vazia';
  String get search => 'Procurar';

  String get redColor => 'Vermelho';
  String get pink => 'Rosa';
  String get purple => 'Roxo';
  String get deepPurple => 'Roxo escuro';
  String get indigo => 'Azul escuro';
  String get blueColor => 'ازرق';
  String get lightBlue => 'ازرق فاتح';
  String get cyan => 'سماوى';
  String get teal => 'تيل';
  String get grey => 'رمادى';
  String get blueGrey => 'ازرق رمادى';
  String get greenColor => 'اخضر';
  String get lightGreen => 'اخضر فاتح';
  String get lime => 'ليمونى';
  String get yellow => 'اصفر';
  String get amber => 'عنبر';
  String get orange => 'برتقالى';
  String get deepOrange => 'برتقالى غامق';
  String get brown => 'بنى';
}

import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'credit_card_information_record.g.dart';

abstract class CreditCardInformationRecord
    implements
        Built<CreditCardInformationRecord, CreditCardInformationRecordBuilder> {
  static Serializer<CreditCardInformationRecord> get serializer =>
      _$creditCardInformationRecordSerializer;

  @nullable
  int get cardnumber;

  @nullable
  String get expirationdate;

  @nullable
  int get verification;

  @nullable
  BuiltList<String> get cardtype;

  @nullable
  String get cardcompany;

  @nullable
  @BuiltValueField(wireName: 'Fullname')
  DocumentReference get fullname;

  @nullable
  int get cardbalance;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(CreditCardInformationRecordBuilder builder) =>
      builder
        ..cardnumber = 0
        ..expirationdate = ''
        ..verification = 0
        ..cardtype = ListBuilder()
        ..cardcompany = ''
        ..cardbalance = 0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('credit_card_information');

  static Stream<CreditCardInformationRecord> getDocument(
          DocumentReference ref) =>
      ref.snapshots().map(
          (s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<CreditCardInformationRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then(
          (s) => serializers.deserializeWith(serializer, serializedData(s)));

  CreditCardInformationRecord._();
  factory CreditCardInformationRecord(
          [void Function(CreditCardInformationRecordBuilder) updates]) =
      _$CreditCardInformationRecord;

  static CreditCardInformationRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createCreditCardInformationRecordData({
  int cardnumber,
  String expirationdate,
  int verification,
  String cardcompany,
  DocumentReference fullname,
  int cardbalance,
}) =>
    serializers.toFirestore(
        CreditCardInformationRecord.serializer,
        CreditCardInformationRecord((c) => c
          ..cardnumber = cardnumber
          ..expirationdate = expirationdate
          ..verification = verification
          ..cardtype = null
          ..cardcompany = cardcompany
          ..fullname = fullname
          ..cardbalance = cardbalance));

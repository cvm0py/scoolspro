import 'package:flutter/material.dart';
import 'package:infixedu/utils/CustomAppBarWidget.dart';

class Policy extends StatelessWidget {
  const Policy({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        title: "Privacy Policy",
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              child: Column(
                children: [
                   Text(
                    "Privacy Policy",
                    style: TextStyle(fontSize: 20, color: Color(0xff3575B6)),
                  ),
                  SizedBox(height: 8,),
                  Text(
                      '''policy ("Policy") describes how the personally identifiable information ("Personal Information") you may provide in the "scoolspro" mobile application ("Mobile Application" or "Service") and any of its related products and services (collectively, "Services") is collected, protected and used. It also describes the choices available to you regarding our use of your Personal Information and how you can access and update this information. This Policy is a legally binding agreement between you ("User", "you" or "your") and this Mobile Application developer ("Operator", "we", "us" or "our"). By accessing and using the Mobile Application and Services, you acknowledge that you have read, understood, and agree to be bound by the terms of this Policy. This Policy does not apply to the practices of companies that we do not own or control, or to individuals that we do not employ or manage.'''),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Automatic collection of information",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff3575B6),
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                      "When you use the Mobile Application, our servers automatically record information that your device sends. This data may include information such as your device's IP address and location, device name and version, operating system type and version, language preferences, information you search for in the Mobile Application, access times and dates, and other statistics."),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                      "Information collected automatically is used only to identify potential cases of abuse and establish statistical information regarding the usage of the Mobile Application and Services. This statistical information is not otherwise aggregated in such a way that would identify any particular user of the system."),
                  Text(
                    "Collection of personal information",
                    style: TextStyle(fontSize: 20, color: Color(0xff3575B6)),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                      "You can access and use the Mobile Application and Services without telling us who you are or revealing any information by which someone could identify you as a specific, identifiable individual. If, however, you wish to use some of the features in the Mobile Application, you may be asked to provide certain Personal Information (for example, your name and e-mail address). We receive and store any information you knowingly provide to us when you create an account, publish content,  or fill any online forms in the Mobile Application. When required, this information may include the following:"),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                      '''- Personal details such as name, country of residence, etc.
- Contact information such as email address, address, etc.
- Account details such as user name, unique user ID, password, etc.
- Geolocation data such as latitude and longitude.
- Certain features on the mobile device such as contacts, calendar, gallery, etc.'''),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                      '''Processing your Personal Information depends on how you interact with the Mobile Application and Services, where you are located in the world and if one of the following applies: (i) you have given your consent for one or more specific purposes; this, however, does not apply, whenever the processing of Personal Information is subject to European data protection law; (ii) provision of information is necessary for the performance of an agreement with you and/or for any pre-contractual obligations thereof; (iii) processing is necessary for compliance with a legal obligation to which you are subject; (iv) processing is related to a task that is carried out in the public interest or in the exercise of official authority vested in us; (v) processing is necessary for the purposes of the legitimate interests pursued by us or by a third party.

 Note that under some legislations we may be allowed to process information until you object to such processing (by opting out), without having to rely on consent or any other of the following legal bases below. In any case, we will be happy to clarify the specific legal basis that applies to the processing, and in particular whether the provision of Personal Information is a statutory or contractual requirement, or a requirement necessary to enter into a contract.'''),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Managing information",
                    style: TextStyle(fontSize: 20, color: Color(0xff3575B6)),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                      "You are able to delete certain Personal Information we have about you. The Personal Information you can delete may change as the Mobile Application and Services change. When you delete Personal Information, however, we may maintain a copy of the unrevised Personal Information in our records for the duration necessary to comply with our obligations to our affiliates and partners, and for the purposes described below. If you would like to delete your Personal Information or permanently delete your account, you can do so on the settings page of your account in the Mobile Application or simply by contacting us."),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Disclosure of information",
                    style: TextStyle(fontSize: 20, color: Color(0xff3575B6)),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                      '''Depending on the requested Services or as necessary to complete any transaction or provide any service you have requested, we may share your information with your consent with our trusted third parties that work with us, any other affiliates and subsidiaries we rely upon to assist in the operation of the Mobile Application and Services available to you. We do not share Personal Information with unaffiliated third parties. These service providers are not authorized to use or disclose your information except as necessary to perform services on our behalf or comply with legal requirements. We may share your Personal Information for these purposes only with third parties whose policies are consistent with ours or who agree to abide by our policies with respect to Personal Information. These third parties are given Personal Information they need only in order to perform their designated functions, and we do not authorize them to use or disclose Personal Information for their own marketing or other purposes.

We will disclose any Personal Information we collect, use or receive if required or permitted by law, such as to comply with a subpoena, or similar legal process, and when we believe in good faith that disclosure is necessary to protect our rights, protect your safety or the safety of others, investigate fraud, or respond to a government request.'''),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Retention of information",
                    style: TextStyle(fontSize: 20, color: Color(0xff3575B6)),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                      "We will retain and use your Personal Information for the period necessary to comply with our legal obligations, resolve disputes, and enforce our agreements unless a longer retention period is required or permitted by law. We may use any aggregated data derived from or incorporating your Personal Information after you update or delete it, but not in a manner that would identify you personally. Once the retention period expires, Personal Information shall be deleted. Therefore, the right to access, the right to erasure, the right to rectification and the right to data portability cannot be enforced after the expiration of the retention period."),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "The rights of users",
                    style: TextStyle(fontSize: 20, color: Color(0xff3575B6)),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                      '''You may exercise certain rights regarding your information processed by us. In particular, you have the right to do the following: (i) you have the right to withdraw consent where you have previously given your consent to the processing of your information; (ii) you have the right to object to the processing of your information if the processing is carried out on a legal basis other than consent; (iii) you have the right to learn if information is being processed by us, obtain disclosure regarding certain aspects of the processing and obtain a copy of the information undergoing processing; (iv) you have the right to verify the accuracy of your information and ask for it to be updated or corrected; (v) you have the right, under certain circumstances, to restrict the processing of your information, in which case, we will not process your information for any purpose other than storing it; (vi) you have the right, under certain circumstances, to obtain the erasure of your Personal Information from us; (vii) you have the right to receive your information in a structured, commonly used and machine readable format and, if technically feasible, to have it transmitted to another controller without any hindrance. This provision is applicable provided that your information is processed by automated means and that the processing is based on your consent, on a contract which you are part of or on pre-contractual obligations there of children

We do not knowingly collect any Personal Information from children under the age of 18. If you are under the age of 18, please do not submit any Personal Information through the Mobile Application and Services. We encourage parents and legal guardians to monitor their children's Internet usage and to help enforce this Policy by instructing their children never to provide Personal Information through the Mobile Application and Services without their permission. If you have reason to believe that a child under the age of 18 has provided Personal Information to us through the Mobile Application and Services, please contact us. You must also be old enough to consent to the processing of your Personal Information in your country (in some countries we may allow your parent or guardian to do so on your behalf).'''),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Email marketing",
                    style: TextStyle(fontSize: 20, color: Color(0xff3575B6)),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                      '''We offer electronic newsletters to which you may voluntarily subscribe at any time. We are committed to keeping your e-mail address confidential and will not disclose your email address to any third parties except as allowed in the information use and processing section or for the purposes of utilizing a third party provider to send such emails. We will maintain the information sent via e-mail in accordance with applicable laws and regulations.

In compliance with the CAN-SPAM Act, all e-mails sent from us will clearly state who the e-mail is from and provide clear information on how to contact the sender. You may choose to stop receiving our newsletter or marketing emails by following the unsubscribe instructions included in these emails or by contacting us. However, you will continue to receive essential transactional emails.'''),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Links to other resources",
                    style: TextStyle(fontSize: 20, color: Color(0xff3575B6)),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                      '''The Mobile Application and Services contain links to other resources that are not owned or controlled by us. Please be aware that we are not responsible for the practices of such other resources or third parties. We encourage you to be aware when you leave the Mobile Application and Services and to read thestatements of each and every resource that may collect Personal Information.'''),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Information security",
                    style: TextStyle(fontSize: 20, color: Color(0xff3575B6)),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                      'We secure information you provide on computer servers in a controlled, secure environment, protected from unauthorized access, use, or disclosure. We maintain reasonable administrative, technical, and physical safeguards in an effort to protect against unauthorized access, use, modification, and disclosure of Personal Information in its control and custody. However, no data transmission over the Internet or wireless network can be guaranteed. Therefore, while we strive to protect your Personal Information, you acknowledge that (i) there are security and limitations of the Internet which are beyond our control; (ii) the security, integrity, and of any and all information and data exchanged between you and the Mobile Application and Services cannot be guaranteed; and (iii) any such information and data may be viewed or tampered with in transit by a third party, despite best efforts.'),
                 Text(
                    "Data breach",
                    style: TextStyle(fontSize: 20, color: Color(0xff3575B6)),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text("In the event we become aware that the security of the Mobile Application and Services has been compromised or users Personal Information has been disclosed to unrelated third parties as a result of external activity, including, but not limited to, security attacks or fraud, we reserve the right to take reasonably appropriate measures, including, but not limited to, investigation and reporting, as well as notification to and cooperation with law enforcement authorities. In the event of a data breach, we will make reasonable efforts to notify affected individuals if we believe that there is a reasonable risk of harm to the user as a result of the breach or if notice is otherwise required by law. When we do, we will post a notice in the Mobile Application, send you an email."),
                     SizedBox(
                    height: 8,
                  ),
                   Text(
                    "Changes and amendments",
                    style: TextStyle(fontSize: 20, color: Color(0xff3575B6)),
                  ),
                    SizedBox(
                    height: 8,
                  ),
                  Text("We reserve the right to modify this Policy or its terms relating to the Mobile Application and Services from time to time in our discretion and will notify you of any material changes to the way in which we treat Personal Information. When we do, we will send you an email to notify you. We may also provide notice to you in other ways in our discretion, such as through contact information you have provided. Any updated version of this Policy will be effective immediately upon the posting of the revised Policy unless otherwise specified. Your continued use of the Mobile Application and Services after the effective date of the revised Policy (or such other act specified at that time) will constitute your consent to those changes. However, we will not, without your consent, use your Personal Information in a manner materially different than what was stated at the time your Personal Information was collected."),
                  SizedBox(
                    height: 8,
                  ),
                   Text(
                    "Acceptance of this policy",
                    style: TextStyle(fontSize: 20, color: Color(0xff3575B6)),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text('''You acknowledge that you have read this Policy and agree to all its terms and conditions. By accessing and using the Mobile Application and Services you agree to be bound by this Policy. If you do not agree to abide by the terms of this Policy, you are not authorized to access or use the Mobile Application and Services. This policy was created with the help of the policy generator at https://www.websiteploicies.com/privacy-policy-generator '''),
                   SizedBox(
                    height: 8,
                  ),
                   Text(
                    "Contacting Us",
                    style: TextStyle(fontSize: 20, color: Color(0xff3575B6)),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text('''If you would like to contact us to understand more about this Policy or wish to contact us concerning any matter relating to individual rights and your Personal Information, you may send an email to admin@scoolspro.com.
                  
                  This document was last updated on March 27, 2021'''),
                  
               
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

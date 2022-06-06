import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

//==Localizations==//
// English and Spanish are included.
// edit this for new languages.
class Local {
  Local(this.locale);

  final Locale locale;

  static Local of(BuildContext context) {
    return Localizations.of<Local>(context, Local)!;
  }

  static const _localizedValues = <String, Map<String, String>>{
    'en': {
      //organization name -- same in every language?
      'orgName': "National Alliance Against Home Repair Fraud",

      //success page
      'success' : 'Success',
      'again' : 'Again',

      //about text
      'aboutText' : 'NAAHRF is a nonprofit organization dedicated to presventing '
          'home repair fraud and scams by empowering homeowners, small businesses, '
          'and communities with tools and knowledge to make better decisions when '
          'hiring a contractor. Since 2009, we have educated over 350,000 homeowners '
          'and counting!',

      'phone' : '(404) 941-6832',
      'email' : 'info@naahrf.org',

      //menu tabs
      'beforeProject': "Before Project",
      'duringProject': "During Project",
      'afterProject': "After Project",

      //before project
      'researchedTheProjectQ': 'Have you researched the project?',
      'researchedTheProjectA':
      'We suggest you go to your local retailers and/or local homebuilder\'s association and ask questions, so you have a '
          'better understanding of what it will take to do your project. This is also a good time to pick out the items you want. For example: '
          'the style of granite or the exact cabinets you want.',
      'consultedArchitectQ':
      'Have you consulted with any architects or engineers?',
      'consultedArchitectA':
      'Sometimes, depending on your project, you may need to consult with specialists'
          'like architects, engineers, or other professionals. You can contact your local home building organization and ask for advice.',
      'gottenThreeEstimatesQ':
      "Have you gotten at least three cost estimates from contractors?",
      'gottenThreeEstimatesA':
      "Be careful if they ask you to sign something! You don't want a quote to become a contract that you are obligated to. We always suggest contacting an attorney if you are not sure what to do. We suggest getting estimates from at least three contractors. This will help you to determine how much you can expect to pay for your project. Get as many estimates as you'd like, but get at least three.",
      'contractingSpecialistsQ':
      "Do these contractors specialize in the work you need to have done?",
      'contractingSpecialistsA':
      "It is a good idea to seek out a contractor who has experience in the work you need done. You wouldn't hire a painter to install electrical wiring because it could be dangerous. Similarly, you wouldn't hire a plumber to fix your roof. Most home repair jobs require expertise.",
      'selectedContractorQ':
      "Have you selected which contractor you are going to use?",
      'selectedContractorA':
      "We suggest making sure you have a good feeling about the contractor you select. Search for them on the Internet to see what comes up. Ask for references from subcontractors they have used. Contact any local home improvement organizations and ask if they have ever heard of them. You may wish to consider doing a criminal background check. Do your homework to find out as much as you can about your contractor.",
      'gottenReferencesQ':
      "Have you gotten references from your contractor's clients and suppliers?",
      'gottenReferencesA':
      "It is a good idea to get at least three references from your contractor. Speaking with three clients your contractor has worked with in the last six months is a great way to get a feel for how your project might turn out.",
      'verifiedInsuranceCoverageQ':
      "Have you verified the contractor's insurance coverage?",
      'verifiedInsuranceCoverageA':
      "A personal insurance agent can help you to make sure your contractor has appropriate insurance to do your project. Imagine if something is accidentally broken in your house or someone is accidentally injured on the job site. Appropriate insurance can help protect against misfortune.",
      'verifiedBusinessLicenseQ':
      "Have you verified that the contractor's \"Business License\" is active and compliant?",
      'verifiedBusinessLicenseA':
      "You can contact your state's Secretary of State's office to confirm that the contractor is licensed to do business in your state. Business licenses help the government to hold businesses accountable for their actions and behavior, as well as protect the health and safety of the public.",
      'verifiedContractorLicenseQ':
      "Have you verified that the contractor's \"Contractor's License\" is active and compliant, where applicable?",
      'verifiedContractorLicenseA':
      "Find out if your contractor's license is active by contacting your local building and zoning department. Some states don't require a contractor to have this license. Keep in mind a Contractor's License is different from a Business License.",
      'verifiedContractorBondedQ':
      "Have you verified that the contractor is bonded, if applicable.",
      'verifiedContractorBondedA':
      "If your contractor is bonded, that means they have purchased a surety bond. A surety bond is an agreement which helps reimburse you if your contractor doesn't do their work correctly or damages your home. Your personal insurance agent can help you determine what types of insurance and bond coverage your contractor has.",
      'consideredBuyingBondQ':
      "Have you considered purchasing a performance bond or some other type of coverage?",
      'consideredBuyingBondA':
      "You can contact your personal insurance agent to help you to decide what types of coverage are best for you and your project. Be sure to ask what is covered under your current homeowner's policy and what is not.",
      'gottenSubcontractorInfoQ':
      "Has the contractor given you the names and background information of all subcontractors?",
      'gottenSubcontractorInfoA':
      "It's important to know everyone who is coming to work on your property, including subcontractors. Stay organized. Ask your contractor for their subcontractor's names and references.",
      'gottenScopeOfWorkQ':
      "Has the contractor given you a Scope of Work detailing everything about the project?",
      'gottenScopeOfWorkA':
      "Be sure to get a Scope of Work from your contractor. This is a document which details everything that needs to be done and how much everything will cost. Do the prices for labor, supplies, taxes, permits, and other charges look correct? You can always contact your local home builder's association or building and zoning department for answers to any questions you may have.",
      'agreedToPayScheduleQ':
      "Have you and your contractor agreed to a payment schedule?",
      'agreedToPayScheduleA':
      "If you and the contractor have agreed to a payment schedule, that agreement should be included and detailed in your contract. We strongly suggest you have an attorney who is licensed in your state review the payment schedule agreement. This is very important.",
      'understandContractQ':
      "Have you thoroughly reviewed and understand the contract?",
      'understandContractA':
      "Contracts are agreements that government enforces. Never sign anything you don't understand or disagree with. We strongly suggest you have an attorney review the contract before you sign it.",
      'lawyerReviewQ':
      "Has your attorney reviewed the contract and advised you on it?",
      'lawyerReviewA':
      "Legal council can help to explain your contract to you in detail. Never sign anything you don't understand or disagree with. We strongly suggest you have an attorney review the contract before you sign it.",
      //during
      'takenPhotosQ': "Have you taken pictures before any work begins?",
      'takenPhotosA':
      "We suggest taking pictures before, during, and after the project. This helps to...",
      'securedValuablesQ': "Have you secured your valuables?",
      'securedValuablesA':
      "We suggest you secure your valuables, including any papers that have personal information written on them.",
      'copiesOfPermitsQ': "Do you have copies of all permits?",
      'copiesOfPermitsA':
      "We suggest you keep personal copies of all permits. Your contractor should be the one to give you copies. You can also get copies from your local building and zoning department.",
      'dailyProgressJournalQ': "Have you started a daily progress journal?",
      'dailyProgressJournalA':
      "When you write in your journal, be sure to include things like the weather, who was on the site at what day and time, what work was done, who showed up late, or anything else you can think of.",
      'takingPicturesThroughoutQ':
      "Are you taking pictures throughout the project?",
      'takingPicturesThroughoutA':
      "We suggest you take pictures before, during, and after the project.",
      'gettingRegularUpdatesQ':
      "Are you getting regular updates of the progress from the contractor?",
      'gettingRegularUpdatesA':
      "We suggest that you communicate regularly with the contractor so they can keep you up to date on the process of the project. Be sure to record these updates in your daily progress journal.",
      'gettingAllChangeOrdersRecordedQ':
      "Are you getting all change orders in writing?",
      'gettingAllChangeOrdersRecordedA':
      "A change order is an amendment to the contract with your contractor that changes the scope of work for the project. We suggest that you get all change orders in writing and add them to the contract. If you are not sure about something, you can contact your attorney to make sure any change orders become part of the contract.",
      //after
      'projectCompletedQ': "Has the project been completed?",
      'projectCompletedA':
      "It is a good idea to inspect the project to make sure it is to your liking. If you are unsure about something, you might consider hiring an inspector to verify that the job has been done correctly. You could also contract your local building and zoning department for more information.",
      'clearedAndCleanedQ': "Has the property been cleared and cleaned?",
      'clearedAndCleanedA':
      "Before you give your contractor their last payment, you might want to consider making sure that all debris, materials, and equipment has been removed from your property.",
      'inspectionsApprovedQ': "Have all inspections been approved?",
      'inspectionsApprovedA':
      "It is a good idea to confirm that all inspections have been approved. You can contact your local building and zoning department to confirm this.",
      'releasesSignedQ': "Have all lien waivers been notarized and signed?",
      'releasesSignedA':
      "It is an excellent idea to get lien waivers/releases signed by the contractor. It shows that he has been paid and will not file a lien against your home for non-payment. You can always get an attorney licensed in your state to explain this to you.",
      'finalPaymentAffidavitSignedQ':
      "Do you have a final payment affidavit signed by your contractor and notarized?",
      'finalPaymentAffidavitSignedA':
      "It is a good idea to get the final payment affidavit notarized to show that you made all payments to your contractor.",
      'haveAllPapersQ': "Do you have all your papers and warranties?",
      'haveAllPapersA':
      "Make sure your contractor explains all warranties to you. It's important to understand exactly what their labor warranty is, not just the manufacturer's warranties.",
      'haveApplicableNoticesQ': "Do you have all applicable notices?",
      'haveApplicableNoticesA':
      "Sometimes, a Notice of Completion or Certificate of Occupancy is required. You can contact your local building and zoning department to determine if you need to get these documents from your contractor.",
    },
    'es': {
      //TODO: finish spanish etc.
      //organization name -- same in every language?
      'orgName': "National Alliance Against Home Repair Fraud",

      //success page
      'success' : 'Success',
      'again' : 'Again',

      //about text
      'aboutText' : 'NAAHRF is a nonprofit organization dedicated to presventing '
          'home repair fraud and scams by empowering homeowners, small businesses, '
          'and communities with tools and knowledge to make better decisions when '
          'hiring a contractor. Since 2009, we have educated over 350,000 homeowners '
          'and counting!',

      'phone' : '(404) 941-6832',
      'email' : 'info@naahrf.org',

      //menu tabs
      'beforeProject': "Before Project",
      'duringProject': "During Project",
      'afterProject': "After Project",

      //before
      'researchedTheProjectQ': '¿Has investigado el proyecto?',
      'researchedTheProjectA':
      'Le sugerimos que vaya a sus minoristas locales yo a la asociación local de constructores de viviendas y haga preguntas, para que tenga un '
          'una mejor comprensión de lo que se necesita para hacer su proyecto. Este también es un buen momento para elegir los artículos que desea. Por ejemplo: '
          'el estilo de granito o los gabinetes exactos que desea.',
      'consultedArchitectQ': '¿Ha consultado con algún arquitecto o ingeniero?',
      'consultedArchitectA':
      'A veces, dependiendo de su proyecto, es posible que deba consultar con especialistas como arquitectos, ingenieros u otros profesionales. Puede ponerse en contacto con su organización local de construcción de viviendas y pedir consejo.',
      'gottenThreeEstimatesQ':
      "Have you gotten at least three cost estimates from contractors?",
      'gottenThreeEstimatesA':
      "Be careful if they ask you to sign something! You don't want a quote to become a contract that you are obligated to. We always suggest contacting an attorney if you are not sure what to do. We suggest getting estimates from at least three contractors. This will help you to determine how much you can expect to pay for your project. Get as many estimates as you'd like, but get at least three.",
      'contractingSpecialistsQ':
      "Do these contractors specialize in the work you need to have done?",
      'contractingSpecialistsA':
      "It is a good idea to seek out a contractor who has experience in the work you need done. You wouldn't hire a painter to install electrical wiring because it could be dangerous. Similarly, you wouldn't hire a plumber to fix your roof. Most home repair jobs require expertise.",
      'selectedContractorQ':
      "Have you selected which contractor you are going to use?",
      'selectedContractorA':
      "We suggest making sure you have a good feeling about the contractor you select. Search for them on the Internet to see what comes up. Ask for references from subcontractors they have used. Contact any local home improvement organizations and ask if they have ever heard of them. You may wish to consider doing a criminal background check. Do your homework to find out as much as you can about your contractor.",
      'gottenReferencesQ':
      "Have you gotten references from your contractor's clients and suppliers?",
      'gottenReferencesA':
      "It is a good idea to get at least three references from your contractor. Speaking with three clients your contractor has worked with in the last six months is a great way to get a feel for how your project might turn out.",
      'verifiedInsuranceCoverageQ':
      "Have you verified the contractor's insurance coverage?",
      'verifiedInsuranceCoverageA':
      "A personal insurance agent can help you to make sure your contractor has appropriate insurance to do your project. Imagine if something is accidentally broken in your house or someone is accidentally injured on the job site. Appropriate insurance can help protect against misfortune.",
      'verifiedBusinessLicenseQ':
      "Have you verified that the contractor's \"Business License\" is active and compliant?",
      'verifiedBusinessLicenseA':
      "You can contact your state's Secretary of State's office to confirm that the contractor is licensed to do business in your state. Business licenses help the government to hold businesses accountable for their actions and behavior, as well as protect the health and safety of the public.",
      'verifiedContractorLicenseQ':
      "Have you verified that the contractor's \"Contractor's License\" is active and compliant, where applicable?",
      'verifiedContractorLicenseA':
      "Find out if your contractor's license is active by contacting your local building and zoning department. Some states don't require a contractor to have this license. Keep in mind a Contractor's License is different from a Business License.",
      'verifiedContractorBondedQ':
      "Have you verified that the contractor is bonded, if applicable.",
      'verifiedContractorBondedA':
      "If your contractor is bonded, that means they have purchased a surety bond. A surety bond is an agreement which helps reimburse you if your contractor doesn't do their work correctly or damages your home. Your personal insurance agent can help you determine what types of insurance and bond coverage your contractor has.",
      'consideredBuyingBondQ':
      "Have you considered purchasing a performance bond or some other type of coverage?",
      'consideredBuyingBondA':
      "You can contact your personal insurance agent to help you to decide what types of coverage are best for you and your project. Be sure to ask what is covered under your current homeowner's policy and what is not.",
      'gottenSubcontractorInfoQ':
      "Has the contractor given you the names and background information of all subcontractors?",
      'gottenSubcontractorInfoA':
      "It's important to know everyone who is coming to work on your property, including subcontractors. Stay organized. Ask your contractor for their subcontractor's names and references.",
      'gottenScopeOfWorkQ':
      "Has the contractor given you a Scope of Work detailing everything about the project?",
      'gottenScopeOfWorkA':
      "Be sure to get a Scope of Work from your contractor. This is a document which details everything that needs to be done and how much everything will cost. Do the prices for labor, supplies, taxes, permits, and other charges look correct? You can always contact your local home builder's association or building and zoning department for answers to any questions you may have.",
      'agreedToPayScheduleQ':
      "Have you and your contractor agreed to a payment schedule?",
      'agreedToPayScheduleA':
      "If you and the contractor have agreed to a payment schedule, that agreement should be included and detailed in your contract. We strongly suggest you have an attorney who is licensed in your state review the payment schedule agreement. This is very important.",
      'understandContractQ':
      "Have you thoroughly reviewed and understand the contract?",
      'understandContractA':
      "Contracts are agreements that government enforces. Never sign anything you don't understand or disagree with. We strongly suggest you have an attorney review the contract before you sign it.",
      'lawyerReviewQ':
      "Has your attorney reviewed the contract and advised you on it?",
      'lawyerReviewA':
      "Legal council can help to explain your contract to you in detail. Never sign anything you don't understand or disagree with. We strongly suggest you have an attorney review the contract before you sign it.",
      //during
      'takenPhotosQ': "Have you taken pictures before any work begins?",
      'takenPhotosA':
      "We suggest taking pictures before, during, and after the project. This helps to...",
      'securedValuablesQ': "Have you secured your valuables?",
      'securedValuablesA':
      "We suggest you secure your valuables, including any papers that have personal information written on them.",
      'copiesOfPermitsQ': "Do you have copies of all permits?",
      'copiesOfPermitsA':
      "We suggest you keep personal copies of all permits. Your contractor should be the one to give you copies. You can also get copies from your local building and zoning department.",
      'dailyProgressJournalQ': "Have you started a daily progress journal?",
      'dailyProgressJournalA':
      "When you write in your journal, be sure to include things like the weather, who was on the site at what day and time, what work was done, who showed up late, or anything else you can think of.",
      'takingPicturesThroughoutQ':
      "Are you taking pictures throughout the project?",
      'takingPicturesThroughoutA':
      "We suggest you take pictures before, during, and after the project.",
      'gettingRegularUpdatesQ':
      "Are you getting regular updates of the progress from the contractor?",
      'gettingRegularUpdatesA':
      "We suggest that you communicate regularly with the contractor so they can keep you up to date on the process of the project. Be sure to record these updates in your daily progress journal.",
      'gettingAllChangeOrdersRecordedQ':
      "Are you getting all change orders in writing?",
      'gettingAllChangeOrdersRecordedA':
      "A change order is an amendment to the contract with your contractor that changes the scope of work for the project. We suggest that you get all change orders in writing and add them to the contract. If you are not sure about something, you can contact your attorney to make sure any change orders become part of the contract.",
      //after
      'projectCompletedQ': "Has the project been completed?",
      'projectCompletedA':
      "It is a good idea to inspect the project to make sure it is to your liking. If you are unsure about something, you might consider hiring an inspector to verify that the job has been done correctly. You could also contract your local building and zoning department for more information.",
      'clearedAndCleanedQ': "Has the property been cleared and cleaned?",
      'clearedAndCleanedA':
      "Before you give your contractor their last payment, you might want to consider making sure that all debris, materials, and equipment has been removed from your property.",
      'inspectionsApprovedQ': "Have all inspections been approved?",
      'inspectionsApprovedA':
      "It is a good idea to confirm that all inspections have been approved. You can contact your local building and zoning department to confirm this.",
      'releasesSignedQ': "Have all lien waivers been notarized and signed?",
      'releasesSignedA':
      "It is an excellent idea to get lien waivers/releases signed by the contractor. It shows that he has been paid and will not file a lien against your home for non-payment. You can always get an attorney licensed in your state to explain this to you.",
      'finalPaymentAffidavitSignedQ':
      "Do you have a final payment affidavit signed by your contractor and notarized?",
      'finalPaymentAffidavitSignedA':
      "It is a good idea to get the final payment affidavit notarized to show that you made all payments to your contractor.",
      'haveAllPapersQ': "Do you have all your papers and warranties?",
      'haveAllPapersA':
      "Make sure your contractor explains all warranties to you. It's important to understand exactly what their labor warranty is, not just the manufacturer's warranties.",
      'haveApplicableNoticesQ': "Do you have all applicable notices?",
      'haveApplicableNoticesA':
      "Sometimes, a Notice of Completion or Certificate of Occupancy is required. You can contact your local building and zoning department to determine if you need to get these documents from your contractor.",
    }
  };

  static List<String> languages() => _localizedValues.keys.toList();

  String get(String s) {
    return _localizedValues[locale.languageCode]![s]!;
  }
}


class LocalDelegate extends LocalizationsDelegate<Local> {
  const LocalDelegate();

  @override
  bool isSupported(Locale locale) =>
      Local.languages().contains(locale.languageCode);

  @override
  Future<Local> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of Local.
    return SynchronousFuture<Local>(Local(locale));
  }

  @override
  bool shouldReload(LocalDelegate old) => false;
}

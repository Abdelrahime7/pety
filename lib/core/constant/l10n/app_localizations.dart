import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'PetPaw+'**
  String get appName;

  /// No description provided for @tagline.
  ///
  /// In en, this message translates to:
  /// **'Caring for your best friends'**
  String get tagline;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get saveChanges;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @keep.
  ///
  /// In en, this message translates to:
  /// **'Keep'**
  String get keep;

  /// No description provided for @discard.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get discard;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// No description provided for @viewRecords.
  ///
  /// In en, this message translates to:
  /// **'View records'**
  String get viewRecords;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @saving.
  ///
  /// In en, this message translates to:
  /// **'Saving…'**
  String get saving;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @pet.
  ///
  /// In en, this message translates to:
  /// **'Pet'**
  String get pet;

  /// No description provided for @notSpecified.
  ///
  /// In en, this message translates to:
  /// **'Not specified'**
  String get notSpecified;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @errorWithMessage.
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String errorWithMessage(String message);

  /// No description provided for @pressBackAgainToExit.
  ///
  /// In en, this message translates to:
  /// **'Press back again to exit'**
  String get pressBackAgainToExit;

  /// No description provided for @unitKg.
  ///
  /// In en, this message translates to:
  /// **'kg'**
  String get unitKg;

  /// No description provided for @unitLbs.
  ///
  /// In en, this message translates to:
  /// **'lbs'**
  String get unitLbs;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navPets.
  ///
  /// In en, this message translates to:
  /// **'Pets'**
  String get navPets;

  /// No description provided for @navHealth.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get navHealth;

  /// No description provided for @navCalendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get navCalendar;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @orContinueWith.
  ///
  /// In en, this message translates to:
  /// **'Or continue with'**
  String get orContinueWith;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullName;

  /// No description provided for @hintFullName.
  ///
  /// In en, this message translates to:
  /// **'John Doe'**
  String get hintFullName;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get emailAddress;

  /// No description provided for @hintEmail.
  ///
  /// In en, this message translates to:
  /// **'name@example.com'**
  String get hintEmail;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @noAccountPrompt.
  ///
  /// In en, this message translates to:
  /// **'Don’t have an account? '**
  String get noAccountPrompt;

  /// No description provided for @haveAccountPrompt.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get haveAccountPrompt;

  /// No description provided for @pleaseEnterName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get pleaseEnterName;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @emailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get emailInvalid;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get passwordTooShort;

  /// No description provided for @accountAndSecurity.
  ///
  /// In en, this message translates to:
  /// **'Account & Security'**
  String get accountAndSecurity;

  /// No description provided for @personalInformation.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInformation;

  /// No description provided for @notificationSettings.
  ///
  /// In en, this message translates to:
  /// **'Notification Settings'**
  String get notificationSettings;

  /// No description provided for @privacyAndSecurity.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Security'**
  String get privacyAndSecurity;

  /// No description provided for @appPreferences.
  ///
  /// In en, this message translates to:
  /// **'App Preferences'**
  String get appPreferences;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose language'**
  String get chooseLanguage;

  /// No description provided for @languageSystem.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get languageSystem;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageArabic.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get languageArabic;

  /// No description provided for @cloudBackup.
  ///
  /// In en, this message translates to:
  /// **'Cloud Backup'**
  String get cloudBackup;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logOut;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @errorLoadingProfile.
  ///
  /// In en, this message translates to:
  /// **'Error loading profile'**
  String get errorLoadingProfile;

  /// No description provided for @changePhoto.
  ///
  /// In en, this message translates to:
  /// **'Change photo'**
  String get changePhoto;

  /// No description provided for @uploadPhoto.
  ///
  /// In en, this message translates to:
  /// **'Upload photo'**
  String get uploadPhoto;

  /// No description provided for @userName.
  ///
  /// In en, this message translates to:
  /// **'User name'**
  String get userName;

  /// No description provided for @emailCannotBeChanged.
  ///
  /// In en, this message translates to:
  /// **'Email cannot be changed manually. '**
  String get emailCannotBeChanged;

  /// No description provided for @contactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get contactSupport;

  /// No description provided for @profileUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get profileUpdated;

  /// No description provided for @profileUpdateCancelled.
  ///
  /// In en, this message translates to:
  /// **'Profile update cancelled'**
  String get profileUpdateCancelled;

  /// No description provided for @subscription.
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get subscription;

  /// No description provided for @memberSince.
  ///
  /// In en, this message translates to:
  /// **'Member since'**
  String get memberSince;

  /// No description provided for @upgrade.
  ///
  /// In en, this message translates to:
  /// **'Upgrade'**
  String get upgrade;

  /// No description provided for @premiumPlan.
  ///
  /// In en, this message translates to:
  /// **'Premium Plan'**
  String get premiumPlan;

  /// No description provided for @freePlan.
  ///
  /// In en, this message translates to:
  /// **'Free Plan'**
  String get freePlan;

  /// No description provided for @premium.
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get premium;

  /// No description provided for @petCareMember.
  ///
  /// In en, this message translates to:
  /// **'Pet Care Member'**
  String get petCareMember;

  /// No description provided for @anonymousUser.
  ///
  /// In en, this message translates to:
  /// **'Anonymous User'**
  String get anonymousUser;

  /// No description provided for @upgradeToPremium.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Premium'**
  String get upgradeToPremium;

  /// No description provided for @premiumSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Give your pets the best care with\nadvanced tracking and insights.'**
  String get premiumSubtitle;

  /// No description provided for @annualPlan.
  ///
  /// In en, this message translates to:
  /// **'Annual Plan'**
  String get annualPlan;

  /// No description provided for @billedYearly.
  ///
  /// In en, this message translates to:
  /// **'Billed yearly'**
  String get billedYearly;

  /// No description provided for @monthlyPlan.
  ///
  /// In en, this message translates to:
  /// **'Monthly Plan'**
  String get monthlyPlan;

  /// No description provided for @flexibleBilling.
  ///
  /// In en, this message translates to:
  /// **'Flexible billing'**
  String get flexibleBilling;

  /// No description provided for @bestValue.
  ///
  /// In en, this message translates to:
  /// **'Best value'**
  String get bestValue;

  /// No description provided for @savePercent.
  ///
  /// In en, this message translates to:
  /// **'Save {percent}%'**
  String savePercent(int percent);

  /// No description provided for @startFreeTrial.
  ///
  /// In en, this message translates to:
  /// **'Start 7-Day Free Trial'**
  String get startFreeTrial;

  /// No description provided for @premiumTerms.
  ///
  /// In en, this message translates to:
  /// **'By continuing, you agree to our Terms of Service and\nPrivacy Policy. Cancel anytime.'**
  String get premiumTerms;

  /// No description provided for @featureUnlimitedPets.
  ///
  /// In en, this message translates to:
  /// **'Unlimited Pets'**
  String get featureUnlimitedPets;

  /// No description provided for @featureUnlimitedPetsDesc.
  ///
  /// In en, this message translates to:
  /// **'Track as many pets as you have in one account.'**
  String get featureUnlimitedPetsDesc;

  /// No description provided for @featureCloudBackup.
  ///
  /// In en, this message translates to:
  /// **'Cloud Backup & Sync'**
  String get featureCloudBackup;

  /// No description provided for @featureCloudBackupDesc.
  ///
  /// In en, this message translates to:
  /// **'Never lose your pet’s medical records or data.'**
  String get featureCloudBackupDesc;

  /// No description provided for @featureFamilySharing.
  ///
  /// In en, this message translates to:
  /// **'Family Sharing'**
  String get featureFamilySharing;

  /// No description provided for @featureFamilySharingDesc.
  ///
  /// In en, this message translates to:
  /// **'Add partners or caregivers to manage pets together.'**
  String get featureFamilySharingDesc;

  /// No description provided for @featurePdfReports.
  ///
  /// In en, this message translates to:
  /// **'PDF Health Reports'**
  String get featurePdfReports;

  /// No description provided for @featurePdfReportsDesc.
  ///
  /// In en, this message translates to:
  /// **'Export records to share with vets or insurance.'**
  String get featurePdfReportsDesc;

  /// No description provided for @premiumBrandTitle.
  ///
  /// In en, this message translates to:
  /// **'{appName} Premium'**
  String premiumBrandTitle(String appName);

  /// No description provided for @getUnlimitedCare.
  ///
  /// In en, this message translates to:
  /// **'Get Unlimited Care'**
  String get getUnlimitedCare;

  /// No description provided for @unlockPremium.
  ///
  /// In en, this message translates to:
  /// **'Unlock multi-pet support, cloud backup,\nand health export features.'**
  String get unlockPremium;

  /// No description provided for @upgradeNowPrice.
  ///
  /// In en, this message translates to:
  /// **'Upgrade Now — {price}/mo'**
  String upgradeNowPrice(String price);

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @chooseNotifications.
  ///
  /// In en, this message translates to:
  /// **'Choose which notifications you want to receive about your pets.'**
  String get chooseNotifications;

  /// No description provided for @appointmentReminders.
  ///
  /// In en, this message translates to:
  /// **'Appointment reminders'**
  String get appointmentReminders;

  /// No description provided for @appointmentRemindersDesc.
  ///
  /// In en, this message translates to:
  /// **'Get notified about your pet’s upcoming appointments.'**
  String get appointmentRemindersDesc;

  /// No description provided for @markAllRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all read'**
  String get markAllRead;

  /// No description provided for @noNotifications.
  ///
  /// In en, this message translates to:
  /// **'No notifications'**
  String get noNotifications;

  /// No description provided for @allCaughtUp.
  ///
  /// In en, this message translates to:
  /// **'You are all caught up! '**
  String get allCaughtUp;

  /// No description provided for @allCaughtUpDesc.
  ///
  /// In en, this message translates to:
  /// **'We will notify you when something needs your attention.'**
  String get allCaughtUpDesc;

  /// No description provided for @justNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get justNow;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @minutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} minute ago} other{{count} minutes ago}}'**
  String minutesAgo(int count);

  /// No description provided for @hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} hour ago} other{{count} hours ago}}'**
  String hoursAgo(int count);

  /// No description provided for @daysAgo.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} day ago} other{{count} days ago}}'**
  String daysAgo(int count);

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning 👋'**
  String get goodMorning;

  /// No description provided for @helloPetParent.
  ///
  /// In en, this message translates to:
  /// **'Hello, Pet Parent!'**
  String get helloPetParent;

  /// No description provided for @makePetHappy.
  ///
  /// In en, this message translates to:
  /// **'Let’s make your pet happy today.'**
  String get makePetHappy;

  /// No description provided for @quickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quickActions;

  /// No description provided for @everythingYourPetNeeds.
  ///
  /// In en, this message translates to:
  /// **'Everything your pet needs'**
  String get everythingYourPetNeeds;

  /// No description provided for @upcomingAppointment.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Appointment'**
  String get upcomingAppointment;

  /// No description provided for @healthOverview.
  ///
  /// In en, this message translates to:
  /// **'Health Overview'**
  String get healthOverview;

  /// No description provided for @unableToLoadPets.
  ///
  /// In en, this message translates to:
  /// **'Unable to load your pets.'**
  String get unableToLoadPets;

  /// No description provided for @myCompanions.
  ///
  /// In en, this message translates to:
  /// **'My Companions'**
  String get myCompanions;

  /// No description provided for @companionsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} beloved companion} other{{count} beloved companions}}'**
  String companionsCount(int count);

  /// No description provided for @everyGreatStory.
  ///
  /// In en, this message translates to:
  /// **'Every great story starts here'**
  String get everyGreatStory;

  /// No description provided for @addFirstCompanionDesc.
  ///
  /// In en, this message translates to:
  /// **'Add your first companion and give them the care they deserve.'**
  String get addFirstCompanionDesc;

  /// No description provided for @addFirstPet.
  ///
  /// In en, this message translates to:
  /// **'Add your first pet'**
  String get addFirstPet;

  /// No description provided for @appointments.
  ///
  /// In en, this message translates to:
  /// **'Appointments'**
  String get appointments;

  /// No description provided for @scheduleVisits.
  ///
  /// In en, this message translates to:
  /// **'Schedule visits'**
  String get scheduleVisits;

  /// No description provided for @healthRecords.
  ///
  /// In en, this message translates to:
  /// **'Health Records'**
  String get healthRecords;

  /// No description provided for @trackHealth.
  ///
  /// In en, this message translates to:
  /// **'Track health'**
  String get trackHealth;

  /// No description provided for @vaccinations.
  ///
  /// In en, this message translates to:
  /// **'Vaccinations'**
  String get vaccinations;

  /// No description provided for @vaccines.
  ///
  /// In en, this message translates to:
  /// **'Vaccines'**
  String get vaccines;

  /// No description provided for @myPets.
  ///
  /// In en, this message translates to:
  /// **'My Pets'**
  String get myPets;

  /// No description provided for @petProfiles.
  ///
  /// In en, this message translates to:
  /// **'Pet profiles'**
  String get petProfiles;

  /// No description provided for @keepTrackVaccineDoses.
  ///
  /// In en, this message translates to:
  /// **'Keep track of vaccine doses'**
  String get keepTrackVaccineDoses;

  /// No description provided for @medicalHistory.
  ///
  /// In en, this message translates to:
  /// **'Medical History'**
  String get medicalHistory;

  /// No description provided for @checkPetHealthRecords.
  ///
  /// In en, this message translates to:
  /// **'Check your pet’s health records'**
  String get checkPetHealthRecords;

  /// No description provided for @addNewPet.
  ///
  /// In en, this message translates to:
  /// **'Add New Pet'**
  String get addNewPet;

  /// No description provided for @addPet.
  ///
  /// In en, this message translates to:
  /// **'Add Pet'**
  String get addPet;

  /// No description provided for @editPet.
  ///
  /// In en, this message translates to:
  /// **'Edit Pet'**
  String get editPet;

  /// No description provided for @petDetails.
  ///
  /// In en, this message translates to:
  /// **'Pet Details'**
  String get petDetails;

  /// No description provided for @deletePet.
  ///
  /// In en, this message translates to:
  /// **'Delete Pet'**
  String get deletePet;

  /// No description provided for @deleting.
  ///
  /// In en, this message translates to:
  /// **'Deleting...'**
  String get deleting;

  /// No description provided for @basicInformation.
  ///
  /// In en, this message translates to:
  /// **'Basic Information'**
  String get basicInformation;

  /// No description provided for @petName.
  ///
  /// In en, this message translates to:
  /// **'Pet name'**
  String get petName;

  /// No description provided for @species.
  ///
  /// In en, this message translates to:
  /// **'Species'**
  String get species;

  /// No description provided for @breed.
  ///
  /// In en, this message translates to:
  /// **'Breed'**
  String get breed;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @dog.
  ///
  /// In en, this message translates to:
  /// **'Dog'**
  String get dog;

  /// No description provided for @cat.
  ///
  /// In en, this message translates to:
  /// **'Cat'**
  String get cat;

  /// No description provided for @bird.
  ///
  /// In en, this message translates to:
  /// **'Bird'**
  String get bird;

  /// No description provided for @birthDate.
  ///
  /// In en, this message translates to:
  /// **'Birth date'**
  String get birthDate;

  /// No description provided for @weight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get weight;

  /// No description provided for @weightLbs.
  ///
  /// In en, this message translates to:
  /// **'Weight (lbs)'**
  String get weightLbs;

  /// No description provided for @neuteredSpayed.
  ///
  /// In en, this message translates to:
  /// **'Neutered / Spayed'**
  String get neuteredSpayed;

  /// No description provided for @medicalNotes.
  ///
  /// In en, this message translates to:
  /// **'Medical notes'**
  String get medicalNotes;

  /// No description provided for @hintPetName.
  ///
  /// In en, this message translates to:
  /// **'e.g. Luna'**
  String get hintPetName;

  /// No description provided for @hintBreed.
  ///
  /// In en, this message translates to:
  /// **'e.g. Golden Retriever'**
  String get hintBreed;

  /// No description provided for @hintWeight.
  ///
  /// In en, this message translates to:
  /// **'0.0'**
  String get hintWeight;

  /// No description provided for @hintAllergies.
  ///
  /// In en, this message translates to:
  /// **'Allergies, chronic conditions, etc.'**
  String get hintAllergies;

  /// No description provided for @hintPetNotes.
  ///
  /// In en, this message translates to:
  /// **'Add notes about your pet...'**
  String get hintPetNotes;

  /// No description provided for @hintEnterPetName.
  ///
  /// In en, this message translates to:
  /// **'Enter pet name'**
  String get hintEnterPetName;

  /// No description provided for @hintEnterBreed.
  ///
  /// In en, this message translates to:
  /// **'Enter breed'**
  String get hintEnterBreed;

  /// No description provided for @hintEnterWeight.
  ///
  /// In en, this message translates to:
  /// **'Enter weight'**
  String get hintEnterWeight;

  /// No description provided for @hintDateMDY.
  ///
  /// In en, this message translates to:
  /// **'mm/dd/yyyy'**
  String get hintDateMDY;

  /// No description provided for @savingYourPet.
  ///
  /// In en, this message translates to:
  /// **'Saving your pet…'**
  String get savingYourPet;

  /// No description provided for @yourPets.
  ///
  /// In en, this message translates to:
  /// **'Your Pets'**
  String get yourPets;

  /// No description provided for @manageFurryFriends.
  ///
  /// In en, this message translates to:
  /// **'Manage all your furry friends in one place.'**
  String get manageFurryFriends;

  /// No description provided for @noPetsAdded.
  ///
  /// In en, this message translates to:
  /// **'You haven’t added any pets yet.'**
  String get noPetsAdded;

  /// No description provided for @noMatchingPets.
  ///
  /// In en, this message translates to:
  /// **'No matching pets found.'**
  String get noMatchingPets;

  /// No description provided for @petNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Pet name is required'**
  String get petNameRequired;

  /// No description provided for @breedRequired.
  ///
  /// In en, this message translates to:
  /// **'Breed is required'**
  String get breedRequired;

  /// No description provided for @weightRequired.
  ///
  /// In en, this message translates to:
  /// **'Weight is required'**
  String get weightRequired;

  /// No description provided for @invalidWeight.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid weight'**
  String get invalidWeight;

  /// No description provided for @birthDateRequired.
  ///
  /// In en, this message translates to:
  /// **'Birth date is required'**
  String get birthDateRequired;

  /// No description provided for @petUpdated.
  ///
  /// In en, this message translates to:
  /// **'Pet updated successfully'**
  String get petUpdated;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @notScheduled.
  ///
  /// In en, this message translates to:
  /// **'Not scheduled'**
  String get notScheduled;

  /// No description provided for @activeSeries.
  ///
  /// In en, this message translates to:
  /// **'Active series: {count}'**
  String activeSeries(int count);

  /// No description provided for @ageYears.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} year} other{{count} years}}'**
  String ageYears(int count);

  /// No description provided for @ageMonths.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} month} other{{count} months}}'**
  String ageMonths(int count);

  /// No description provided for @ageYearsOld.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} year old} other{{count} years old}}'**
  String ageYearsOld(int count);

  /// No description provided for @ageMonthsOld.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} month old} other{{count} months old}}'**
  String ageMonthsOld(int count);

  /// No description provided for @lessThanMonth.
  ///
  /// In en, this message translates to:
  /// **'Less than a month'**
  String get lessThanMonth;

  /// No description provided for @lessThanYear.
  ///
  /// In en, this message translates to:
  /// **'Less than a year'**
  String get lessThanYear;

  /// No description provided for @puppyKitten.
  ///
  /// In en, this message translates to:
  /// **'Puppy / Kitten'**
  String get puppyKitten;

  /// No description provided for @petsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} pet} other{{count} pets}}'**
  String petsCount(int count);

  /// No description provided for @health.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get health;

  /// No description provided for @allHealthRecords.
  ///
  /// In en, this message translates to:
  /// **'All Health Records'**
  String get allHealthRecords;

  /// No description provided for @selectPetToViewRecords.
  ///
  /// In en, this message translates to:
  /// **'Select a pet to view their records.'**
  String get selectPetToViewRecords;

  /// No description provided for @searchByNameOrBreed.
  ///
  /// In en, this message translates to:
  /// **'Search by name or breed...'**
  String get searchByNameOrBreed;

  /// No description provided for @failedToLoadPets.
  ///
  /// In en, this message translates to:
  /// **'Failed to load pets.'**
  String get failedToLoadPets;

  /// No description provided for @unableToLoadHealthRecords.
  ///
  /// In en, this message translates to:
  /// **'Unable to load health records.'**
  String get unableToLoadHealthRecords;

  /// No description provided for @couldNotLoadRecords.
  ///
  /// In en, this message translates to:
  /// **'We could not load the health records.'**
  String get couldNotLoadRecords;

  /// No description provided for @healthRecordAdded.
  ///
  /// In en, this message translates to:
  /// **'Health record added successfully'**
  String get healthRecordAdded;

  /// No description provided for @addHealthRecord.
  ///
  /// In en, this message translates to:
  /// **'Add Health Record'**
  String get addHealthRecord;

  /// No description provided for @recordInformation.
  ///
  /// In en, this message translates to:
  /// **'Record Information'**
  String get recordInformation;

  /// No description provided for @recordType.
  ///
  /// In en, this message translates to:
  /// **'Record type'**
  String get recordType;

  /// No description provided for @selectRecordTypeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Select the type of health record'**
  String get selectRecordTypeSubtitle;

  /// No description provided for @whatKindOfRecord.
  ///
  /// In en, this message translates to:
  /// **'What kind of health record are you adding?'**
  String get whatKindOfRecord;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @hintRecordTitle.
  ///
  /// In en, this message translates to:
  /// **'e.g. Annual checkup'**
  String get hintRecordTitle;

  /// No description provided for @pleaseEnterTitle.
  ///
  /// In en, this message translates to:
  /// **'Please enter a title'**
  String get pleaseEnterTitle;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @whenDidThisHappen.
  ///
  /// In en, this message translates to:
  /// **'When did this happen?'**
  String get whenDidThisHappen;

  /// No description provided for @veterinarian.
  ///
  /// In en, this message translates to:
  /// **'Veterinarian'**
  String get veterinarian;

  /// No description provided for @hintVetName.
  ///
  /// In en, this message translates to:
  /// **'e.g. Dr. Sarah Smith'**
  String get hintVetName;

  /// No description provided for @hintAdditionalInfo.
  ///
  /// In en, this message translates to:
  /// **'Add any additional information...'**
  String get hintAdditionalInfo;

  /// No description provided for @keepRecordsUpToDate.
  ///
  /// In en, this message translates to:
  /// **'Keep your pet’s health records up to date to make it easier to track their health history.'**
  String get keepRecordsUpToDate;

  /// No description provided for @noHealthRecordsYet.
  ///
  /// In en, this message translates to:
  /// **'No health records yet'**
  String get noHealthRecordsYet;

  /// No description provided for @healthRecordsWillAppear.
  ///
  /// In en, this message translates to:
  /// **'Health records for all your pets will appear here.'**
  String get healthRecordsWillAppear;

  /// No description provided for @healthRecordsForPetWillAppear.
  ///
  /// In en, this message translates to:
  /// **'Health records for {petName} will appear here.'**
  String healthRecordsForPetWillAppear(String petName);

  /// No description provided for @noFilteredRecords.
  ///
  /// In en, this message translates to:
  /// **'No {type} records'**
  String noFilteredRecords(String type);

  /// No description provided for @noFilteredRecordsForPet.
  ///
  /// In en, this message translates to:
  /// **'There are no {type} records for {petName}.'**
  String noFilteredRecordsForPet(String type, String petName);

  /// No description provided for @showingRecordsFor.
  ///
  /// In en, this message translates to:
  /// **'Showing records for'**
  String get showingRecordsFor;

  /// No description provided for @addingRecordFor.
  ///
  /// In en, this message translates to:
  /// **'Adding record for'**
  String get addingRecordFor;

  /// No description provided for @recordsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} record} other{{count} records}}'**
  String recordsCount(int count);

  /// No description provided for @yourPetsHealth.
  ///
  /// In en, this message translates to:
  /// **'Your pets’ health'**
  String get yourPetsHealth;

  /// No description provided for @recordsAcrossPets.
  ///
  /// In en, this message translates to:
  /// **'{records} across {pets}'**
  String recordsAcrossPets(String records, String pets);

  /// No description provided for @vaccination.
  ///
  /// In en, this message translates to:
  /// **'Vaccination'**
  String get vaccination;

  /// No description provided for @checkup.
  ///
  /// In en, this message translates to:
  /// **'Checkup'**
  String get checkup;

  /// No description provided for @medication.
  ///
  /// In en, this message translates to:
  /// **'Medication'**
  String get medication;

  /// No description provided for @allergy.
  ///
  /// In en, this message translates to:
  /// **'Allergy'**
  String get allergy;

  /// No description provided for @surgery.
  ///
  /// In en, this message translates to:
  /// **'Surgery'**
  String get surgery;

  /// No description provided for @treatment.
  ///
  /// In en, this message translates to:
  /// **'Treatment'**
  String get treatment;

  /// No description provided for @grooming.
  ///
  /// In en, this message translates to:
  /// **'Grooming'**
  String get grooming;

  /// No description provided for @allVaccinations.
  ///
  /// In en, this message translates to:
  /// **'All Vaccinations'**
  String get allVaccinations;

  /// No description provided for @unableToLoadVaccinations.
  ///
  /// In en, this message translates to:
  /// **'Unable to load vaccinations.'**
  String get unableToLoadVaccinations;

  /// No description provided for @failedToLoadVaccinations.
  ///
  /// In en, this message translates to:
  /// **'Failed to load vaccinations'**
  String get failedToLoadVaccinations;

  /// No description provided for @noVaccinationsYet.
  ///
  /// In en, this message translates to:
  /// **'No vaccinations yet'**
  String get noVaccinationsYet;

  /// No description provided for @keepPetHealthyAddVaccinations.
  ///
  /// In en, this message translates to:
  /// **'Keep your pet healthy by adding their vaccinations.'**
  String get keepPetHealthyAddVaccinations;

  /// No description provided for @vaccinationRecordsWillAppear.
  ///
  /// In en, this message translates to:
  /// **'Vaccination records for all your pets will appear here.'**
  String get vaccinationRecordsWillAppear;

  /// No description provided for @addVaccination.
  ///
  /// In en, this message translates to:
  /// **'Add Vaccination'**
  String get addVaccination;

  /// No description provided for @savingVaccination.
  ///
  /// In en, this message translates to:
  /// **'Saving vaccination…'**
  String get savingVaccination;

  /// No description provided for @vaccinationAdded.
  ///
  /// In en, this message translates to:
  /// **'Vaccination added successfully'**
  String get vaccinationAdded;

  /// No description provided for @vaccinationDetails.
  ///
  /// In en, this message translates to:
  /// **'Vaccination Details'**
  String get vaccinationDetails;

  /// No description provided for @vaccinationHistory.
  ///
  /// In en, this message translates to:
  /// **'Vaccination history'**
  String get vaccinationHistory;

  /// No description provided for @vaccinationSeries.
  ///
  /// In en, this message translates to:
  /// **'Vaccination series'**
  String get vaccinationSeries;

  /// No description provided for @createNewSeries.
  ///
  /// In en, this message translates to:
  /// **'Create new series'**
  String get createNewSeries;

  /// No description provided for @useExistingSeries.
  ///
  /// In en, this message translates to:
  /// **'Use existing series'**
  String get useExistingSeries;

  /// No description provided for @vaccinationDate.
  ///
  /// In en, this message translates to:
  /// **'Vaccination date'**
  String get vaccinationDate;

  /// No description provided for @vaccinationDateRequired.
  ///
  /// In en, this message translates to:
  /// **'Vaccination date is required'**
  String get vaccinationDateRequired;

  /// No description provided for @hintVaccinationNotes.
  ///
  /// In en, this message translates to:
  /// **'Optional notes about this vaccination...'**
  String get hintVaccinationNotes;

  /// No description provided for @vaccine.
  ///
  /// In en, this message translates to:
  /// **'Vaccine'**
  String get vaccine;

  /// No description provided for @vaccineName.
  ///
  /// In en, this message translates to:
  /// **'Vaccine name'**
  String get vaccineName;

  /// No description provided for @hintVaccineName.
  ///
  /// In en, this message translates to:
  /// **'e.g. Rabies'**
  String get hintVaccineName;

  /// No description provided for @vaccineNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Vaccine name is required'**
  String get vaccineNameRequired;

  /// No description provided for @numberOfDoses.
  ///
  /// In en, this message translates to:
  /// **'Number of doses'**
  String get numberOfDoses;

  /// No description provided for @hintDoses.
  ///
  /// In en, this message translates to:
  /// **'e.g. 3'**
  String get hintDoses;

  /// No description provided for @enterValidDoses.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid number of doses'**
  String get enterValidDoses;

  /// No description provided for @doseProgress.
  ///
  /// In en, this message translates to:
  /// **'Dose progress'**
  String get doseProgress;

  /// No description provided for @requiredDoses.
  ///
  /// In en, this message translates to:
  /// **'Required doses'**
  String get requiredDoses;

  /// No description provided for @dose.
  ///
  /// In en, this message translates to:
  /// **'Dose'**
  String get dose;

  /// No description provided for @doseNumber.
  ///
  /// In en, this message translates to:
  /// **'Dose {number}'**
  String doseNumber(int number);

  /// No description provided for @nextDose.
  ///
  /// In en, this message translates to:
  /// **'Next dose: {number}'**
  String nextDose(int number);

  /// No description provided for @dosesCompleted.
  ///
  /// In en, this message translates to:
  /// **'{completed}/{total} doses completed'**
  String dosesCompleted(int completed, int total);

  /// No description provided for @dosesOfRequired.
  ///
  /// In en, this message translates to:
  /// **'{completed} / {total} doses'**
  String dosesOfRequired(int completed, int total);

  /// No description provided for @dosesCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} dose} other{{count} doses}}'**
  String dosesCount(int count);

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @created.
  ///
  /// In en, this message translates to:
  /// **'Created'**
  String get created;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @inProgress.
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get inProgress;

  /// No description provided for @selectSeries.
  ///
  /// In en, this message translates to:
  /// **'Select series'**
  String get selectSeries;

  /// No description provided for @selectASeries.
  ///
  /// In en, this message translates to:
  /// **'Select a series'**
  String get selectASeries;

  /// No description provided for @selectVaccinationSeries.
  ///
  /// In en, this message translates to:
  /// **'Select Vaccination Series'**
  String get selectVaccinationSeries;

  /// No description provided for @noActiveSeries.
  ///
  /// In en, this message translates to:
  /// **'No active vaccination series found. '**
  String get noActiveSeries;

  /// No description provided for @createNewSeriesInstead.
  ///
  /// In en, this message translates to:
  /// **'Create a new series instead.'**
  String get createNewSeriesInstead;

  /// No description provided for @loadingSeries.
  ///
  /// In en, this message translates to:
  /// **'Loading series...'**
  String get loadingSeries;

  /// No description provided for @noSeriesFound.
  ///
  /// In en, this message translates to:
  /// **'No series found.'**
  String get noSeriesFound;

  /// No description provided for @searchVaccine.
  ///
  /// In en, this message translates to:
  /// **'Search vaccine...'**
  String get searchVaccine;

  /// No description provided for @unknownPet.
  ///
  /// In en, this message translates to:
  /// **'Unknown pet'**
  String get unknownPet;

  /// No description provided for @appointment.
  ///
  /// In en, this message translates to:
  /// **'Appointment'**
  String get appointment;

  /// No description provided for @newAppointment.
  ///
  /// In en, this message translates to:
  /// **'New Appointment'**
  String get newAppointment;

  /// No description provided for @editAppointment.
  ///
  /// In en, this message translates to:
  /// **'Edit Appointment'**
  String get editAppointment;

  /// No description provided for @scheduleAppointment.
  ///
  /// In en, this message translates to:
  /// **'Schedule Appointment'**
  String get scheduleAppointment;

  /// No description provided for @schedulingAppointment.
  ///
  /// In en, this message translates to:
  /// **'Scheduling appointment…'**
  String get schedulingAppointment;

  /// No description provided for @cancelAppointmentTitle.
  ///
  /// In en, this message translates to:
  /// **'Cancel appointment?'**
  String get cancelAppointmentTitle;

  /// No description provided for @cancelAppointmentMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel this appointment? This action cannot be undone.'**
  String get cancelAppointmentMessage;

  /// No description provided for @cancelVisit.
  ///
  /// In en, this message translates to:
  /// **'Cancel visit'**
  String get cancelVisit;

  /// No description provided for @upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcoming;

  /// No description provided for @past.
  ///
  /// In en, this message translates to:
  /// **'Past'**
  String get past;

  /// No description provided for @noAppointmentsYet.
  ///
  /// In en, this message translates to:
  /// **'No appointments yet.'**
  String get noAppointmentsYet;

  /// No description provided for @noAppointmentsOnDay.
  ///
  /// In en, this message translates to:
  /// **'No appointments on this day.'**
  String get noAppointmentsOnDay;

  /// No description provided for @pleaseSelectPet.
  ///
  /// In en, this message translates to:
  /// **'Please select a pet'**
  String get pleaseSelectPet;

  /// No description provided for @pleaseSelectDateTime.
  ///
  /// In en, this message translates to:
  /// **'Please select date and time'**
  String get pleaseSelectDateTime;

  /// No description provided for @selectPet.
  ///
  /// In en, this message translates to:
  /// **'Select pet'**
  String get selectPet;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @dateAndTime.
  ///
  /// In en, this message translates to:
  /// **'Date & time'**
  String get dateAndTime;

  /// No description provided for @hintDateTime.
  ///
  /// In en, this message translates to:
  /// **'mm / dd / yyyy , --:-- --'**
  String get hintDateTime;

  /// No description provided for @hintAnythingVetShouldKnow.
  ///
  /// In en, this message translates to:
  /// **'Anything the vet should know...'**
  String get hintAnythingVetShouldKnow;

  /// No description provided for @dateRequired.
  ///
  /// In en, this message translates to:
  /// **'Date is required'**
  String get dateRequired;

  /// No description provided for @vetNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Veterinarian name is required'**
  String get vetNameRequired;

  /// No description provided for @editing.
  ///
  /// In en, this message translates to:
  /// **'Editing'**
  String get editing;

  /// No description provided for @petDetailsUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Pet details unavailable'**
  String get petDetailsUnavailable;

  /// No description provided for @completedOn.
  ///
  /// In en, this message translates to:
  /// **'Completed {date}'**
  String completedOn(String date);

  /// No description provided for @appointmentWithPet.
  ///
  /// In en, this message translates to:
  /// **'Appointment — {petName}'**
  String appointmentWithPet(String petName);

  /// No description provided for @doctorWithPet.
  ///
  /// In en, this message translates to:
  /// **'{doctor} — {petName}'**
  String doctorWithPet(String doctor, String petName);

  /// No description provided for @noNotesAdded.
  ///
  /// In en, this message translates to:
  /// **'No notes added.'**
  String get noNotesAdded;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

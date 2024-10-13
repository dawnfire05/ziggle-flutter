import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:ziggle/app/di/locator.dart';
import 'package:ziggle/app/modules/common/presentation/widgets/ziggle_app_bar.dart';
import 'package:ziggle/app/modules/common/presentation/widgets/ziggle_button.dart';
import 'package:ziggle/app/modules/common/presentation/widgets/ziggle_row_button.dart';
import 'package:ziggle/app/modules/core/data/models/analytics_event.dart';
import 'package:ziggle/app/modules/core/domain/enums/language.dart';
import 'package:ziggle/app/modules/core/domain/enums/page_source.dart';
import 'package:ziggle/app/modules/core/domain/repositories/analytics_repository.dart';
import 'package:ziggle/app/modules/user/domain/repositories/language_setting_repository.dart';
import 'package:ziggle/app/modules/user/domain/repositories/notification_setting_repository.dart';
import 'package:ziggle/app/modules/user/presentation/bloc/auth_bloc.dart';
import 'package:ziggle/app/modules/user/presentation/bloc/developer_option_bloc.dart';
import 'package:ziggle/app/modules/user/presentation/bloc/user_bloc.dart';
import 'package:ziggle/app/router.gr.dart';
import 'package:ziggle/app/values/palette.dart';
import 'package:ziggle/app/values/strings.dart';
import 'package:ziggle/gen/strings.g.dart';

@RoutePage()
class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage>
    with AutoRouteAwareStateMixin<SettingPage> {
  @override
  void didPush() =>
      AnalyticsRepository.pageView(const AnalyticsEvent.profileSetting());
  @override
  void didPopNext() =>
      AnalyticsRepository.pageView(const AnalyticsEvent.profileSetting());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ZiggleAppBar.compact(
        backLabel: context.t.user.myInfo,
        from: PageSource.setting,
        title: Text(context.t.user.setting.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Title(title: context.t.user.account.title),
              BlocBuilder<UserBloc, UserState>(builder: (context, state) {
                if (state.user == null) {
                  return BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, authState) {
                      return ZiggleButton.cta(
                        loading: authState.isLoading,
                        child: Text(context.t.user.account.login),
                        onPressed: () {
                          AnalyticsRepository.click(
                              const AnalyticsEvent.profileLogin(
                                  PageSource.setting));
                          context.read<AuthBloc>().add(const AuthEvent.login(
                              source: PageSource.setting));
                        },
                      );
                    },
                  );
                }
                return Column(
                  children: [
                    ZiggleRowButton(
                      title: Text(context.t.user.account.logout),
                      destructive: true,
                      showChevron: false,
                      onPressed: () {
                        AnalyticsRepository.click(
                            const AnalyticsEvent.profileLogout(
                                PageSource.setting));
                        context.read<AuthBloc>().add(
                            const AuthEvent.logout(source: PageSource.setting));
                      },
                    ),
                    const SizedBox(height: 20),
                    ZiggleRowButton(
                      title: Text(context.t.user.account.withdraw),
                      destructive: true,
                      showChevron: false,
                      onPressed: () {
                        AnalyticsRepository.click(
                            const AnalyticsEvent.profileWithdraw());
                        launchUrlString(Strings.withdrawalUrl);
                      },
                    ),
                  ],
                );
              }),
              _Title(title: context.t.user.setting.notification.title),
              FutureBuilder(
                future:
                    sl<NotificationSettingRepository>().isNotificationEnabled(),
                builder: (context, snapshot) {
                  final data = snapshot.data;
                  if (data == null) return const SizedBox.shrink();
                  if (!data) {
                    return ZiggleRowButton(
                      title: Text(context.t.user.setting.notification.enable),
                      onPressed: () {
                        AnalyticsRepository.click(const AnalyticsEvent
                            .profileSettingEnableNotification());
                        sl<NotificationSettingRepository>()
                            .enableNotification();
                      },
                    );
                  }
                  return ZiggleRowButton(
                    title: Text(context.t.user.setting.notification.enabled),
                    disabled: true,
                    showChevron: false,
                  );
                },
              ),
              _Title(title: context.t.user.setting.language.title),
              ZiggleRowButton(
                title: Text(context.t.user.setting.language.setKorean),
                showChevron: false,
                disabled: LocaleSettings.currentLocale == AppLocale.ko,
                onPressed: LocaleSettings.currentLocale == AppLocale.ko
                    ? null
                    : () {
                        AnalyticsRepository.click(
                          const AnalyticsEvent.profileSettingLanguage(
                              AppLocale.ko),
                        );
                        LocaleSettings.setLocale(AppLocale.ko);
                        sl<LanguageSettingRepository>()
                            .setLanguage(Language.ko);
                        context.router.replaceAll([SplashRoute(delay: true)]);
                      },
              ),
              const SizedBox(height: 20),
              ZiggleRowButton(
                title: Text(context.t.user.setting.language.setEnglish),
                showChevron: false,
                disabled: LocaleSettings.currentLocale == AppLocale.en,
                onPressed: LocaleSettings.currentLocale == AppLocale.en
                    ? null
                    : () {
                        AnalyticsRepository.click(
                          const AnalyticsEvent.profileSettingLanguage(
                              AppLocale.en),
                        );
                        LocaleSettings.setLocale(AppLocale.en);
                        sl<LanguageSettingRepository>()
                            .setLanguage(Language.en);
                        context.router.replaceAll([SplashRoute(delay: true)]);
                      },
              ),
              _Title(title: context.t.user.setting.information.title),
              ZiggleRowButton(
                title: Text(context.t.user.setting.information.title),
                onPressed: () {
                  AnalyticsRepository.click(
                      const AnalyticsEvent.profileSettingInformation());
                  const InformationRoute().push(context);
                },
              ),
              BlocBuilder<DeveloperOptionBloc, DeveloperOptionState>(
                builder: (context, state) => state.enabled
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _Title(title: context.t.user.developMode.title),
                          ZiggleRowButton(
                            showChevron: false,
                            title: Text(context.t.user.developMode.disable),
                            onPressed: () => context
                                .read<DeveloperOptionBloc>()
                                .add(const DeveloperOptionEvent.disable()),
                          ),
                          const SizedBox(height: 20),
                          ZiggleRowButton(
                            showChevron: false,
                            title: Text(
                              context.t.user.developMode.toggleChannel(
                                channel: state.apiChannel.name,
                              ),
                            ),
                            onPressed: () {
                              context.read<DeveloperOptionBloc>().add(
                                  const DeveloperOptionEvent.toggleChannel());
                              context.router.replaceAll([
                                SplashRoute(delay: true),
                              ]);
                            },
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 6),
      child: Text(
        title,
        style: const TextStyle(
          color: Palette.black,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

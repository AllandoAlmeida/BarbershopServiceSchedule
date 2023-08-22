import 'package:dw_barbershop/src/core/ui/helpers/form_helper.dart';
import 'package:dw_barbershop/src/core/ui/helpers/messages.dart';
import 'package:dw_barbershop/src/feateres/auth/register/user_register_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

class UserRegisterPage extends ConsumerStatefulWidget {
  const UserRegisterPage({super.key});

  @override
  ConsumerState<UserRegisterPage> createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends ConsumerState<UserRegisterPage> {
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserRegisterVm = ref.watch(userRegisterVmProvider.notifier);
    ref.listen(userRegisterVmProvider, (__, state) {
      switch (state) {
        case UserRegisterStateStatus.initial:
        case UserRegisterStateStatus.success:
        case UserRegisterStateStatus.error:
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onTapOutside: (_) => context.unfocus(),
                  controller: nameEC,
                  validator: Validatorless.required('Nome obrigatorio'),
                  decoration: const InputDecoration(
                    label: Text('Nome'),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  onTapOutside: (_) => context.unfocus(),
                  controller: emailEC,
                  validator: Validatorless.multiple([
                    Validatorless.required("E-mail obrigatório"),
                    Validatorless.email('E-mail inválido'),
                  ]),
                  decoration: const InputDecoration(
                    label: Text('E-mail'),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  onTapOutside: (_) => context.unfocus(),
                  controller: passwordEC,
                  validator: Validatorless.multiple([
                    Validatorless.required("Senha obrigatória"),
                    Validatorless.min(
                        6, 'Senha deve ter no minímo 6 caracteres'),
                  ]),
                  obscureText: true,
                  decoration: const InputDecoration(
                    label: Text('password'),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  onTapOutside: (_) => context.unfocus(),
                  validator: Validatorless.multiple([
                    Validatorless.required("Confirmar a senha é obrigatório"),
                    Validatorless.compare(passwordEC, 'Senhas divergentes'),
                  ]),
                  obscureText: true,
                  decoration: const InputDecoration(
                    label: Text('Confirm Password'),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(56)),
                  onPressed: () {
                    switch (formKey.currentState?.validate()) {
                      case null || false:
                        Messages.showError('Formulário inválido', context);
                      case true:
                        UserRegisterVm.register(
                            name: nameEC.text,
                            email: emailEC.text,
                            password: passwordEC.text);
                    }
                  },
                  child: const Text('CRIAR CONTA'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
